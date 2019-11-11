# 目录

* [简介](#简介)
* [入门教程](#入门教程)
* [进阶篇](#进阶教程)


# 简介

本篇主要介绍基本环境的搭建方法，本篇文章结束的时候，你将会学习到：

- 安装 Python 环境
- 安装并配置 Git
- 创建 Python

# 入门教程

入门教程中，主要包括 zsh 配置，git 工具安装。

## zsh

确认你使用的是 *ng 系统，常见的 Linux 发行版 和 Mac/OS 都是类 ng 系统。

首先确认你的发行版中安装有 zsh shell:
```shell
ls -lash /usr/bin
```

如果没有 zsh 的话，你需要自行通过发行版的包管理工具安装，此处以 Fedora 为例:
```shell
sudo dnf install zsh
```

安装完成之后，更改默认的 shell 为 zsh:
```shell
sudo chsh -s /usr/bin/zsh
```

安装 zsh 扩展，oh-my-zsh:
```shell
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## git

首先确认 git 是否已经安装:
```shell
which git
```

如果没有安装的话，使用发行版默认的包管理器安装:
```shell
sudo dnf install git
```

配置 git 的用户名和邮箱信息:
```shell
git config --global user.name "Your name"
git config --global user.email "your_email@example.com"
```

配置 git 的 http 代理，正常情况下不需要使用代理，在访问 github 受限的情况下，需要配置
git 代理，具体的配置方法如下：
```shell
git config --global http.proxy "socks5:127.0.0.1:8080"
git config --global https.proxy "socks5:127.0.0.1:8080"
```

基本的 git 使用可以参考以下文档:

* [Github 简明教程](http://bob.36deep.com/github-tutorial)
* [Git 基本操作](http://lingxiankong.github.io/2014-07-18-git-notes.html)
* [Git Branch](http://nvie.com/posts/a-successful-git-branching-model/)
* [深入浅出Git权限校验](http://mp.weixin.qq.com/s?__biz=MzAxMTczMjgzMQ==&mid=2650587852&idx=1&sn=0c2144c7bc30a6176e309290eb50fc75&scene=1&srcid=06170Qz47CZilcjbK4kCR31J&from=groupmessage&isappinstalled=0)


## 安装 Python 环境

一般的发行版默认带有 Python2.7，所以基本上不用自己再安装了。

使用发行版自带的包管理工具安装 pip 工具:
```shell
sudo dnf install pip2
```

使用pip安装 setuptools 和 virtualenv:
```shell
sudo pip install setuptools virtualenv virtualenvwrapper
```

`virtualenvwrapp` 的使用说明请参照[官方文档](http://virtualenvwrapper.readthedocs.io/en/latest/)。

## 使用`miniconda`管理python

下载并安装`miniconda`，这里以`linux`为例：
```shell
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
```

将下面的配置写到`.zshrc`中：
```shell
export PATH="/path/to/miniconda3/bin:$PATH"
. /path/to/miniconda3/etc/profile.d/conda.sh
```

## 配置 oh-my-zsh

oh-my-zsh 初始化加载配置的地方在 `~/.zshrc`，在该文件中需要
添加 `virtualenvwrapper` 的初始化脚本:
```shell
export WORK_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
source /usr/bin/virtualenvwrapper.sh
```

## 其余好用的 shell 插件推荐

+ [z](https://github.com/rupa/z)
+ [ngrep网络抓包](https://github.com/jpr5/ngrep)
+ [htop](https://github.com/hishamhm/htop)
+ [slurm网络带宽检测](https://github.com/mattthias/slurm)
+ [httpie 命令行 postman](https://github.com/jakubroztocil/httpie)

## 配置代理

- [SS代理搭建和配置](./static/articles/shadowsocks.md)

# 进阶教程

这部分主要分类介绍 Python 的知识。

## Python 基本知识

+ [Python 10分钟](./tutorial-1.md)
+ [面向对象](./tutorial-2.md)
+ [Google Docs](https://developers.google.com/edu/python/), a very simple guide.
+ [Web Code Style Guide](./static/articles/web-code-style-guide.md), simple python web style guide.
+ [The Hitchhiker’s Guide to Python](http://docs.python-guide.org/en/latest/), learn code style and map of python libs.

## 基础扩展

+ [Python Memory Management](http://nodefe.com/implement-of-pymalloc-from-source/)
+ [Python 锁](./static/articles/python-lock.md)
+ [ClassMethod VS StaticMethod](http://stackoverflow.com/questions/136097/what-is-the-difference-between-staticmethod-and-classmethod-in-python)

## Web 开发

+ [Let’s Build A Web Server. Part 1.](https://ruslanspivak.com/lsbaws-part1/)
+ [Let’s Build A Web Server. Part 2.](https://ruslanspivak.com/lsbaws-part2/)
+ [Let’s Build A Web Server. Part 3.](https://ruslanspivak.com/lsbaws-part3/)

## Web 开发扩展

+ [Web Network Basic Tutorial](./static/articles/web-network-basic-tutorial.md)
+ [HTTP TCP UDP](http://mp.weixin.qq.com/s?__biz=MzAxODI5ODMwOA==&mid=2666539211&idx=1&sn=629d1115b3992572d94b5d3e2295eb0f&scene=0)
+ [Simple Python Framework From Scratch](http://mattscodecave.com/posts/simple-python-framework-from-scratch.html)

## 开发工具推荐

+ vim
+ vscode
+ pycharm

之所以推荐 vim 是因为使用 vim 是必须的，而且有时候结合 linux 系统命令的话 vim 查询代码比较快捷。
## 网络知识
+ [OpenVPN 协议基础](https://www.saminiir.com/openvpn-puts-packets-inside-your-packets/)
+ [ARP 协议理解](https://www.saminiir.com/lets-code-tcp-ip-stack-1-ethernet-arp/)

## 其他资料汇总
+ [show me the code](https://github.com/Yixiaohan/show-me-the-code)
+ [Python初学者](https://github.com/Yixiaohan/codeparkshare)
