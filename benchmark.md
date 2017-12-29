
## Django Golang 性能测试

一直以来使用的都是 python, 但是最近接触到了 golang 做的应用，为了一绝高下，
最近把我学到的 Django 框架的东西，调优什么的都给用上了，来了下两个框架的测试对比，主要涉及的框架是：

- Django
- gin


### 已知问题

- django 基于 python， 使用的动态类型
- gin 基于 golang, 使用静态类型

就功能而言，使用两者开发了同样的功能，都是基于 redis 的一个任务队列，其中 django 开发起来要简单很多，而 golang 开发起来要困难很多，总体而言两者测试都差不多，基本的功能都可以实现。

### 测试条件

- 8C 12G intel i7
- redis (127.0.0.1)
- ulimit -n 204800
- sysctl -w net.core.somaxconn=204800
- 100% CPU


### uwsgi 配置

其中 uwsgi 的日志运行时进行了重定，无附加的磁盘 IO 干扰。

``` ini
[uwsgi]
master = true
module = wsgi
http = 127.0.0.1:8887
home = /home/smileboywtu/.virtualenvs/etau
chdir = /home/smileboywtu/workspace/Kajiki/api
pythonpath = /home/smileboywtu/workspace/Kajiki/api/pro_setting
processes = 8
listen = 1024
harakiri = 60
socket-timeout = 300
reload-on-as = 2048
reload-on-rss = 512
reload-mercy = 10
vacuum = true
max-requests = 5000
buffer-size = 30000
thunder-lock = true

memory-report = true
log-master = true
log-x-forwarded-for = true
logformat = [CORE: %(core)] [RES/%(rssM)MB VIRT/%(vszM)MB] [pid: %(pid)] %(addr) [%(ltime)] %(method) %(uri) => generated %(size) bytes in %(msecs) msecs (%(proto) %(status))

gevent = 1000
gevent-early-monkey-patch = true
```

### 测试工具

- wrk

测试参数：

- Django: `./wrk -c10000 -d10 "http://127.0.0.1:8887/api/nuri/kajiki/execmd/" -s LemonTree/post.lua`
- Gin: `./wrk -c100000 -d10 "http://127.0.0.1:9999/v1/nserver2/execmd/" -s LemonTree/post.lua`

### 测试结果

Golang:

``` shell
Running 10s test @ http://127.0.0.1:9999/v1/nserver2/execmd/
  2 threads and 100000 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    21.12ms    6.38ms  74.64ms   81.19%
    Req/Sec    23.84k     3.20k   29.92k    71.13%
  461031 requests in 10.12s, 101.56MB read
  Socket errors: connect 98981, read 0, write 0, timeout 0
Requests/sec:  45569.55
Transfer/sec:     10.04MB
```

Python:

``` shell
Running 10s test @ http://127.0.0.1:8887/api/nuri/kajiki/execmd/
  2 threads and 10000 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   630.34ms  194.23ms   1.99s    92.21%
    Req/Sec   802.99    238.51     1.51k    77.11%
  14286 requests in 11.00s, 2.89MB read
  Socket errors: connect 8981, read 14286, write 0, timeout 333
Requests/sec:   1298.23
Transfer/sec:    269.25KB
```
