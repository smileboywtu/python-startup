# 目录

1. 简介
2. 特点
3. 源码解析
    1. 系统结构
    2. 工作流
    3. 细节解析
4. 从中学到的

# 简介

[Howdoi](https://github.com/gleitz/howdoi) 是一个非常棒的python应用，他允许程序员使用命令行来搜索常见的一些命令，这些答案都来自stackoverflow上面star最多的答案，可以使用这个工具搜索些简单的问题，比如：

``` shell
➜ howdoi format date shell
DATE=`date +%Y-%m-%d`
```

上面的这个命令搜索如何在shell中格式化日期，当然除了搜索程序代码外你也可以用来搜索一些常见的问题，比如搜索git和svn各自的特点：

``` shell
➜ howdoi git vs svn
Git is not better than Subversion. But is also not
worse. It's different. The key difference is that it
is decentralized. Imagine you are a developer on the
road, you develop on your laptop and you want to have
source control so that you can go back 3 hours...
```
这个时候你可以打开google搜索：

``` shell
git vs svn site:www.stackoverflow.com
```

这两个答案是一样的，不过使用howdoi的话，你不必要打开浏览器，你只需要在命令行就可以完成答案的搜索，但是如果是成片的文字阅读的话，使用浏览器更好，段落分割做的好一些，在命令行上面阅读大片的文字很费力。

# 特点

+ 支持goolge和stackoverflow搜索
+ 支持系统全局http(s)代理
+ 支持代码高亮
+ 支持SSL
+ 支持选择答案

具体的细节和功能，详见使用说明：

``` shell
usage: howdoi [-h] [-p POS] [-a] [-l] [-c] [-n NUM_ANSWERS] [-C] [-v]
              [QUERY [QUERY ...]]

instant coding answers via the command line

positional arguments:
  QUERY                 the question to answer

optional arguments:
  -h, --help            show this help message and exit
  -p POS, --pos POS     select answer in specified position (default: 1)
  -a, --all             display the full text of the answer
  -l, --link            display only the answer link
  -c, --color           enable colorized output
  -n NUM_ANSWERS, --num-answers NUM_ANSWERS
                        number of answers to return
  -C, --clear-cache     clear the cache
  -v, --version         displays the current version of howdoi

```

# 源码解析

从功能来看该程序主要使用代理并结合google来获取stackoverflow上面的star最多的答案，但是设计上面有众多细节可以学习，下面的是我列举的几点：

- 解析系统全局代理
- google高级搜索
- 网页抓取与跳转
- 代码高亮

## 系统结构

这个项目是一个单脚本的项目，其中作者的高明之处并不体现在结构设计上面，以下简单的将程序划分为三个部分，输入，输出，处理：

<img class="img-responsive" src="../images/howdoi-architechture.png" alt="system architechture">

图中的箭头表示调用关系，程序的核心部分是通过google和stackoverflow搜索最佳的答案。

## 工作流

整个项目的工作流程如下：

<img class="img-responsive" src="../images/howdoi-workflow.png" alt="system architechture">

各个阶段的主要执行过程在图中标注了出来，如果划分为不同的阶段，每个过程的处理细节也会有所不同，这只是其中一种方式，本文剩下的细节也会参照这四个阶段来解读。

## 细节解析

### http proxy

你从源代码仓库中下载下来的代码，并不能很好的开始工作，这个应用默认使用系统的http(s)代理，我们先来看看这部分的代码:

``` python
def get_proxies():
    proxies = getproxies()
    filtered_proxies = {}
    for key, value in proxies.items():
        if key.startswith('http'):
            if not value.startswith('http'):
                filtered_proxies[key] = 'http://%s' % value
            else:
                filtered_proxies[key] = value
    return filtered_proxies
```

从上面的代码可以看出程序会获取系统的代理信息，从中筛选出http(s)代理，所以在运行这个程序以前，注意检查系统变量中是否有http(s)代理的环境变量设置。
