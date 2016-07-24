# python spider use cookies

当你在使用爬虫抓取网页的时候，你可能需要登陆，以前的登陆的时候仅仅需要使用账户和密码就行了，但是现在各色的验证码横行，不乏由高级的，使用机器学习来做人机验证，所以单纯的通过用户名和密码来登陆不太可行，但是我们需要抓取数据，需要登陆，一种办法就是使用cookie来请求数据，cookie中包含了登陆后的认证信息。

下面介绍下python下面使用cookie来请求数据的办法：

# 场景

一次帮助一个妹子抓取qichacha.com上面的企业信息，她拿这些信息主要是做公司的销售资料，寻找意向客户，她找到了我，让我帮他查资料，我肯定不想自己手动搜索阿，所以我就想到了用爬虫来解决问题，这就遇到了登陆的问题。

# 具体方案

首先我们需要使用firefox来登陆qichacha.com网站，登陆过后我们的cookie信息就被缓存到浏览器中，所以需要我们提取出来，这里我们可以使用firefox的插件firebug来提取出cookies到文件中，但是这里需要我们注意一个问题，cookie的存储由两种常见的格式：
+ Netscape HTTP Cookie File
+ LWP

由于firebug默认导出`Netscape HTTP Cookie File`格式，但是导出的文件格式还是有问题，需要我们自己在处理下，但是使用Chrome的话可以直接导入到python中使用，下面来了解下cookie的文件格式：

`Netscape HTTP Cookie File`的格式如下：

``` shell
域 [TRUE或FALSE]　　/　[TRUE或FALSE]　　过期时间戳　　名称　　内容
```

保存的`cookies.txt`格式需要满足：

1. 首行必须是：`# Netscape HTTP Cookie File.`
2. 格式要严格为（空白处为TAB）

# Python中使用Cookie

这里使用urllib2, cookielib:

``` python2

# -*- coding: utf-8 -*-

import urllib2
import cookielib

cookie = cookielib.MozillaCookieJar()
cookie.load("cookies.txt")
handle = urllib2.HTTPCookieProcessor(cookie)
opener = urllib2.build_opener(handle)
urllib2.install_opener(opener)

```

这里安装之后就是全局的，以后所有的通过`urllib2`发送的请求自动带上这个`cookie`.