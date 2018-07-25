# 走进新时代

由于国内网络屏蔽，很多国外的优质资源，国内用户是没有办法使用的，出于
学习的考虑，本篇分享下几个常见的代理问题和解决办法。

# 目录

* [SS 代理搭建](# 代理搭建)
* [流量加速](# 流量加速)
* [代理转换](# 代理转换)

# 代理搭建

shadowsocks 是一个比较轻量化的代理，搭建起来相对简单，推荐使用 Python 的
shadowsocks 包，如果你的系统发行版里面有相应的 shadowsocks 包的话，也推荐使用
系统的包，自带开机启动。

## 服务端

服务端推荐使用 Python 的客户端。
登录你的服务器，确保该服务器可以连接“外网”:
```shell
curl www.google.com
```
如果返回正确，说明网络是通的。

要求服务器的配置大于 128M，另外带宽足够，网络质量好。

### 安装

下面我以centos为例来说明安装步骤：

首先是需要安装 shadowsocks 客户端：
```shell
yum install libsodium
pip install shadowsocks
```
安装完成后检查是否安装成功：
```shell
which ssserver
which sslocal
```
确保这两个安装完成。

### 内核调整

内核调整参数，参照 shadowsocks 官方网站：

```shell
vim /etc/sysctl.conf

fs.file-max = 51200

net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 4096

net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mem = 25600 51200 102400
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_congestion_control = hybla
```

其中很多选项的调整可以自行百度查阅，也可以参考后文给出的链接。

### 配置文件

示例配置：

```json
{
    "server":"0.0.0.0",
    "server_port": 8080,
    "port_password": {
        "8080": "123456",
    },
    "timeout":300,
    "method":"chacha20",
    "fast_open": true,
    "workers": 20
}
```
其中 `port_password` 是可以配置多个端口，多个不同的密码的，另外最后的 `workers` 参数指定 `worker` 的数量。

### 运行服务器

运行服务端程序：

```shell
ssserver -c shadowsocks.json --pid-file shadowsocks.pid -d start
```

检查端口是否正常：
```shell
netstat -antp | grep 8080
```

### Docker 配置方法

docker file 如下：
```Dockerfile
FROM python:3.6-alpine

RUN apk add libsodium-dev
RUN pip install shadowsocks

COPY ./shadowsocks.json /shadowsocks.json

ENTRYPOINT ["ssserver", "-c", "shadowsocks.json"]

EXPOSE 8080
```

## 客户端

客户端的下载推荐去[官网](https://shadowsocks.org/en/download/clients.html)。

### 配置

客户端是 GUI 程序，直接填入服务端的参数即可，服务器的地址填写服务器的外网地址，端口，密码，加密方法与 shadowsocks.json 中的配置保持一致。

### 浏览器配置

浏览器推荐使用 Chrome ，配合插件 SwitchyOmega 使用，以上两者推荐使用离线包安装。

在 omega 中增加一个情景模式，代理类型选择 socks5，ip 填写127.0.0.1，端口填写1080。

shadowsocks 客户端程序会在连接服务端之后，建立一个本地的 socks5 监听，这个监听是没有认证的，所以浏览器可以配置，switchyOmega 中不能认证，所以不能使用 switchyOmega 直接连接服务端。

# 流量加速

我们的云主机一般都在国外，我们在国内，虽然网络是通了，但是由于网路比较长，要走跨海光缆通信，延时较正常的国内访问要慢很多，根本原因是距离比较远，所以我们需要对流量进行加速。

## 选择加速服务商

第一种比较靠谱的选择是使用有服务商提供的专门的加速服务，比如说微林，这个注册需要邀请码，如果有需要的话，可以找我提供。

一般服务商提供的服务比较稳定，服务支持也相对较好，不想自己折腾的，可以选择购买服务商的流量加速服务。

## 国内云

如果想自己加速流量，可以选择国内阿里云和腾讯云的服务，通过流量转发来加速。云服务提供商的带宽有优化，可以提供较好的网络状况，但是弊端是可能一年的开销要比专业的服务提供商更多。

这里以 centos 7 为例，假设服务端监听的端口是8989，服务器的公网地址是：121.73.256.36

```shell
sudo firewall-cmd --set-default-zone=public

sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent

sudo firewall-cmd --zone=public --add-forward-port=port=8080:proto=tcp:toport=8080:toaddr=121.73.256.36 --permanent

sudo firewall-cmd --reload
```

然后客户端直接连接国内云服务器的 8080 端口即可。

## 对比

你可以使用网站 [http://ping.pe](http://ping.pe) 来检验两者的差异性。

# 代理转化

代理转换是指在不同的代理协议之间切换。这里我比较推荐使用 `cow` 工具来做转换。

## Cow

项目地址： [https://github.com/cyfdecyf/cow](https://github.com/cyfdecyf/cow)

从 shadowsocks 代理转换成 http 代理，配置示例：
```shell
listen = http://0.0.0.0:1080
proxy = ss://aes-128-cfb:password@1.2.3.4:8080
core 2
```

# 参考

* [SNAT和DNAT](https://www.cnblogs.com/mangood/p/6024053.html)
* [Enable BBR Centos 7](https://www.vultr.com/docs/how-to-deploy-google-bbr-on-centos-7)
* [Linux后台高并发优化](https://www.jianshu.com/p/e0b52dc702d6)