# Python Dep 包

用Python做Web开发，很多时候都是选择合适的组件，然后拼装在一起，一旦方案成熟后，
基本上后续产品的开发和迭代都会使用相同的组件结构，那么这个时候就可以把零散化的
组件打包在一起，生成模板后，可以直接使用和打包成`deb`文件安装。

# 打包环境依赖

打包系统的目的是把Django web应用打包成系统的deb包，然后安装使用。

- ubuntu 14.04
- python
- virtualenv
- debhelper
- django
- uwsgi
- nginx

# 基础打包环境构建

基础的打包构建环境应该与实际的生产环境类似，如系统版本，Python运行版本等需要保持一致。
基础的打包环境需要安装基础的python 编译工具链和virtualenv deb工具：

- Python
    + pip
    + setuptools
    + virtualenv

- ubuntu
    + dh-virtualenv (package python virtual env)
    + debhelper (extend deb helper for dh virtualenv used in debian/rules)
    + equivs (Preinst,Postinst,Prerm,Postrm trigger scripts)
    + devscripts

- wheels
    + 自定义的wheel包

除了需要确保打包系统安装了上述依赖外，还需要提前准备好自有的一些python包，最好打成wheel格式
这样可以减少系统c库的依赖。

``` shell

# 卸载系统自带的python工具
apt-get purge -qq -y python-setuptools python-pip python-virtualenv

# 安装打包必须的系统依赖
apt-get install -qq -y build-essential debhelper devscripts equivs

# 安装dh-virtualenv
( cd /tmp && curl -LO "http://mirrors.kernel.org/ubuntu/pool/universe/d/dh-virtualenv/dh-virtualenv_1.0-1_all.deb" )
sudo dpkg -i /tmp/dh-virtualenv_1.0-1_all.deb

# 安装自己的pip virtualenv setuptools wheel
export WHEEL_HOME=~/wheels
export PIP_WHEEL = $WHEEL_HOME/pip-8.1.2-py2.py3-none-any.whl
python $PIP_WHEEL/pip install $PIP_WHEEL
python $PIP_WHEEL/pip install $WHEEL_HOME/setuptools-32.3.0-py2.py3-none-any.whl
python $PIP_WHEEL/pip install $WHEEL_HOME/wheel-0.29.0-py2.py3-none-any.whl
python $PIP_WHEEL/pip install $WHEEL_HOME/virtualenv-15.1.0-py2.py3-none-any.whl

# 复制自己的wheel包到dh-virtualenv 的根目录下
export DH_VIRTUAL_ENV_HOME=/opt/www/venvs
mkdir -p $DH_VIRTUAL_ENV_HOME
cp -r $WHEEL_HOME $DH_VIRTUAL_ENV_HOME

# 配置pip，使用清华大学python源
mkdir -p ~/.pip
cat > ~/.pip/pip.conf <<EOL
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
disable-pip-version-check = true
EOL
```

# Python web框架

我们默认Python Web框架的基本组件有：
- Django
- UWSGI
- NGINX

使用uwsgi来代理Django应用，然后通过nginx来做负载均衡。

# Web框架的基本结构

假如我们的模块名称为：`wechat`
目录结构如下：

- api
    + conf
        - wechat.ini
        - wechat.conf
    + scripts
        - updateconfig.py
    + pro_setting
        - uwsgi.py
        - settings.py
        - \_\_init\_\_.py
        - urls.py
    + wechat
        - \_\_init\_\_.py
        - urls.py
        - views.py
        - models.py
        - serializers.py
    + config
        - \_\_init\_\_.py
        - constants.py
        - globalconf.py
    + requirements.txt

其中个别文件含义如下：
- wechat.ini： uwsgi配置文件
- wechat.conf: nginx upstream 配置
- updateconfig.py: 用来更新globalconf.py中的配置
- requirements.txt: python web应用依赖的python包

uwsgi样本配置如下：
注意log文件的位置，不要冲突了，另外uwsgi和nginx之间通过socket文件通信，这样
可以很简单实现单机多个模块部署冲突问题，另外样例中多出了gevent的配置，如果你不需要
可以注释掉。
``` ini
[uwsgi]
master=true
module=wsgi
chmod-socket=666
socket=/tmp/wechat.sock
home= /opt/www/venvs/$(VENV_NAME)
chdir=/opt/www/$(MODULE_NAME)
pythonpath=/opt/www/$(MODULE_NAME)/pro_setting
processes=4
harakiri = 60
socket-timeout=300
limit-as=512
reload-mercy=10
vacuum=true
max-requests=10000
buffer-size=30000
thunder-lock=true

daemonize=/var/log/uwsgi/$(MODULE_NAME).log
memory-report=true
log-master = true
log-x-forwarded-for = true
logformat = [RES/%(rssM)MB VIRT/%(vszM)MB] [pid: %(pid)] %(addr) [%(ltime)] %(method) %(uri) => generated %(size) bytes in %(msecs) msecs (%(proto) %(status))

gevent=100
gevent-early-monkey-patch=true

```

nginx upstream 样本配置如下：
``` conf
location ~ ^/api/wechat/ {
    uwsgi_pass unix:///tmp/wechat.sock;
    include uwsgi_params;
}
```
安装的时候需要将这个文件拷贝到nginx upstream 配置文件夹下面。

关于web应用配置的问题，上例中给出了一个文件`updataconfig.py`这个文件会在安装的时候来更新web应用的配置，这个时候你可以
通过文件的方式，将配置写入一个文件中，比如`wechat.yaml`放在一个固定的文件夹下面，应用安装前将配置文件拷贝到部署机器上面，
或者与配置分发系统对接，通过网络获取配置，方式多种多样，只要能达到更新配置的目的即可。

# 打包文件目录结构

打包我们还是以wechat模块为例：

+ api
+ build
    - wechat-api
        + changelog
        + compat
        + control
        + init
        + install
        + postinst
        + postrm
        + preinst
        + prerm
        + rules
        + triggers

在开始详述各个文件的用途之前，我们先来看看部署一个web应用我们需要做什么？
+ nginx配置加载
+ uwsgi配置加载
+ 应用自启动
+ 应用配置修改
+ 系统依赖安装
+ 数据库配置更新

关于uwsgi和nginx的配置，我们已经给出了样例，问题就是需要把文件拷贝到一个文件夹下面，
然后重启应用，关于自启动，我们其实需要一个自启动脚本，应用配置修改可以使用`updateconfig.py`，
问题是什么时候运行这个文件，系统依赖更新，这个可以直接用deb的依赖关系解决，关于数据库部分，
这里并不做太多的详述，根据需求来，尽量集中管理，可以使用配置分发系统来完成这个任务，不建议
放在包里面初始化，后面更新逻辑会很复杂。

先来看看自启动脚本：
``` shell
#!/bin/sh

### BEGIN INIT INFO
# Provides:          uwsgi
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop uWSGI server instance(s)
# Description:       This script manages uWSGI server instance(s).
#                    You could control specific instance(s) by issuing:
#
#                        service uwsgi <command> <confname> <confname> ...
#
#                    You can issue to init.d script following commands:
#                      * start        | starts daemon
#                      * stop         | stops daemon
#                      * reload       | sends to daemon SIGHUP signal
#                      * force-reload | sends to daemon SIGTERM signal
#                      * restart      | issues 'stop', then 'start' commands
#                      * status       | shows status of daemon instance
#
#                    For more details see /usr/share/doc/uwsgi/README.Debian.
### END INIT INFO

export MODULE_NAME=wechat
export VENV_NAME=wechat-api
PATH=/opt/www/venvs/$VENV_NAME/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/opt/www/venvs/$VENV_NAME/bin/uwsgi

OWNER=www-data

NAME=$VENV_NAME
DESC=$VENV_NAME

test -x $DAEMON || exit 0

DAEMON_OPTS="--ini /opt/www/uwsgi/$MODULE_NAME.ini"

case "$1" in
    start)
        echo -n "Starting $DESC: "
        start-stop-daemon --start --chuid $OWNER:$OWNER --user $OWNER --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
    ;;
    stop)
        echo -n "Stopping $DESC: "
        start-stop-daemon --signal 3 --user $OWNER --quiet --retry 2 --stop --exec $DAEMON
        echo "$NAME."
    ;;
    reload)
        killall -1 $DAEMON
    ;;
    force-reload)
        killall -15 $DAEMON
    ;;
    restart)
        echo -n "Restarting $DESC: "
        start-stop-daemon --signal 3 --user $OWNER --quiet --retry 2 --stop --exec $DAEMON
        sleep 1
        start-stop-daemon --user $OWNER --start --quiet --chuid $OWNER:$OWNER  --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
    ;;
    status)
        killall -10 $DAEMON
    ;;
    *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|restart|reload|force-reload|status}" >&2
        exit 1
    ;;
esac

exit 0
```

上面这段是`init`文件的样例内容，这里我们编写了uwsgi的自启动配置脚本，这段脚本中，我们指定了
`virtualenv`home的路径，模块的名字和uwsgi的加载路径，从uwsgi的加载路径我们知道，我们需要把
我们的uwsgi配置文件放在/opt/www/uwsgi下面，注意模块名字`wechat-api`这个也是debian包的名字。

在deb包的制作过程中`install`文件是用来拷贝文件的，具体的我们需要把web api的代码和配置拷贝到
约定的地点，这个地方我们知道uwsgi配置的路径，那么我们看看一个样例：

``` shell
api/* /opt/www/api/wechat/
api/conf/wechat.ini /opt/www/uwsgi/
api/conf/wechat.conf /opt/www/nginx/
```
这个地方我们指定了uwsgi的文件配置，api的配置，nginx的配置，我们需要修改nginx的upstream的文件夹
应该是/opt/www/nginx/下面，那么我们指明了api的路径，那么我们uwsgi配置文件中`chdir`应该指向/opt/www/wechat
下面。

到这里我们完成了文件的移动和自启动文件的加载，那么这个过程中很重要的一点就是理清楚他们之间的对应和依赖关系，
uwsgi配置，nginx配置相对独立，但是uwsgi和api的路径对应关系应该理清楚，同样uwsgi中socket的位置应该和
nginx upstream的配置对应起来。

接下来我们先来看看虚拟环境的加载和python依赖的安装：

在uwsgi的配置文件中，我们需要指定python web应用的虚拟环境，这个地方是`/opt/www/venvs`，那么我们在启动脚本
中需要确保使用的是这个路径下面的virtualenv环境，安装的时候我们需要把我们的env安装到这个目录下面，来看看rules
的样例文件：

``` shell
#!/usr/bin/make -f
#
# Build Debian package using https://github.com/spotify/dh-virtualenv
#
# Increase trace logging, see debhelper(7) (uncomment to enable)
# export DH_VERBOSE=1
export DH_VIRTUALENV_INSTALL_ROOT=/opt/www/venvs/

%:
	dh $@ --with python-virtualenv

override_dh_virtualenv:
	dh_virtualenv --skip-install --extra-virtualenv-arg "--no-download" --extra-pip-arg "--find-links=/opt/www/venvs/wheels" --requirements api/requirements.txt

override_dh_strip:
	true

override_dh_shlibdeps:
	true

```

这个文件中，我们安装了api的依赖指定文件`requirements.txt`并指定了安装目录为`/opt/www/venvs`，并且我们还指定了
本地的搜索目录，为了有些我们自己打包的wheel包，或者一些需要保证各模块虚拟环境一致的包，放在这个目录下，免去了网上
下载不统一的问题。

最后让我们来看看配置加载的文件，postinst文件样例：

``` shell
#!/bin/sh
# postinst script
#
# see: dh_installdeb(1)

set -e

# summary of how this script can be called:
#        * <postinst> `configure' <most-recently-configured-version>
#        * <old-postinst> `abort-upgrade' <new version>
#        * <conflictor's-postinst> `abort-remove' `in-favour' <package>
#          <new-version>
#        * <postinst> `abort-remove'
#        * <deconfigured's-postinst> `abort-deconfigure' `in-favour'
#          <failed-install-package> <version> `removing'
#          <conflicting-package> <version>
# for details, see http://www.debian.org/doc/debian-policy/ or
# the debian-policy package


configure() {
    MODULE_NAME=wechat
    VENV_NAME=wechat-api

    PYTHON=/opt/www/venvs/$VENV_NAME/bin/python
    WEB_PROJECT_DIR=/opt/www/$MODULE_NAME
    PRO_LOG_DIR=/var/log/pro
    UWSGI_LOG_DIR=/var/log/uwsgi

    # create user
    adduser --system --group --no-create-home --quiet apache || true

    # make log dir
    mkdir -p $PRO_LOG_DIR
    touch $PRO_LOG_DIR/$MODULE_NAME.log && chown -R apache:apache $PRO_LOG_DIR

    mkdir -p $UWSGI_LOG_DIR
    touch $UWSGI_LOG_DIR/$MODULE_NAME.log && chown -R apache:apache $UWSGI_LOG_DIR

    # update config.yaml
    $PYTHON $WEB_PROJECT_DIR/scripts/updateconfig.py

    if [ -x /etc/init.d/wechat-api ]; then
        service wechat-api restart
    fi

    if [ -x /etc/init.d/nginx ]; then
        service nginx reload
    fi
}

case "$1" in
    configure)
        echo "postinst -> $1"
        configure
    ;;

    abort-upgrade|abort-remove|abort-deconfigure)
        echo "postinst -> $1"
    ;;

    *)
        echo "postinst called with unknown argument \`$1'" >&2
        exit 1
    ;;
esac

# dh_installdeb will replace this with shell code automatically
# generated by other debhelper scripts.

#DEBHELPER#

exit 0
```

我们最后剩下的就是我们的包名字和所需要的系统dep依赖关系我们还未定义，定义这些的文件是control:

``` shell
Source: wechat-api
Section: python
Priority: extra
Maintainer: someone <someone@example.com>
Build-Depends: debhelper (>= 9), python, dh-virtualenv, python-dev, libmysqlclient-dev
Standards-Version: 1.0.0

Package: wechat-api
Architecture: any
Depends: python-dev, libmysqlclient-dev
Description: wechat-api
```

这个文件可以分为两段，第一段指向源文件的打包，第二段指向的是打包后的deb文件安装。

至此我们的应用的所有配置，除了数据库的外，我们的其他流程应该是都已经满足了，接下来就是打包过程和安装过程。

# 打包和安装

打包过程结合和deb的依赖安装打包和dh-virtualenv的打包：
``` shell
ln -s build/wechat-api/debian debian
mk-build-deps --install debian/control
dpkg-buildpackage -uc -us -b
```

打包完成后，生成的deb文件在父级目录下面。

安装过程可以分为源安装和dpkg安装，源安装的方法是我们先把dep包推送到我们自己的源中，然后使用`apt-get`安装，
而dpkg安装过程是我们直接把包拷贝到目标机器上面，然后用dpkg安装即可。


``` shell

# 创建源目录
mkdir -p /opt/deps

# 创建源仓库
apt-get install dpkg-dev

# 将自己打好包放在/opt/deps下面
cp wechat-api.*.deb  /opt/deps

# 更新自己的源
cd /opt/deps
dpkg-scanpackages amd64 | gzip -9c > Packages.gz

# 启动源监听
cd /opt/deps
python -m SimpleHTTPServer 8000

# 在目标机器上面更新源列表
echo “deb http://x.x.x.x:8000/opt/debs/ amd64/” >> /etc/apt/sources.list

# 安装
apt-get update
apt-get install wechat-api

```

本篇完~

# 参考

- [dh-virtualenv](https://github.com/spotify/dh-virtualenv#using-dh-virtualenv)
- [wheel package](http://codingpy.com/article/how-to-write-your-own-python-packages/)
- [通过源安装](http://www.ithov.com/linux/100860.shtml)