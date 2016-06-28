规范学习：

# 有意思的开始

我们的测试： 你的BUG, 就是他们工作的成果

我们的客户： 你个BUG，就是价格谈判的筹码

我们的对手： 你的BUG, 就是他们胜利的关键

评测机构：	 你个BUG, 就是他们收入的来源

# python编码规范

**1**. 保存为utf-8 

``` python
# -*- coding: utf-8 -*-

```

**2**. 文件的头部应该有注释说明：

- 文件的内容
- 作者
- 版本
- 版权信息
- 修改时间

``` python
# 支付信息管理模块
# Created: 2016-06-28
# Copyright: (C) 2016<smileboywtu@gmail.com>
```

**3**. 关于代码注释

- 类功能说明
- 类参数说明
- 类返回值说明
- 难理解的部分注释
- 出过问题的地方注释

``` python
def sample_func(param1, param2, user='smileboywtu):
    """this is a demo function to illustrate func docs

    you can add the long description here, maybe some function details.

    Args:
        param1(type): description
        param2(type): description. long description should be
            idented.
        param3(type, optional): description

    Returns:
        bool: true for success, false otherwise.

    Raise:
        AttributeError: The ``Raises`` section is a list of all
            exceptions that are relevant to the interface.
        ValueError: If `param2` is equal to `param1`.
    """
    pass
```

**4**. 变量命名

- 不要使用没有意义的变量如： i, j, a, b, c
- 变量小写，常量大写，函数名字使用下划线连接
- 私有成员使用下划线开头
- 好的规范不止一种，团队内部使用一致的编码规范

**5**. 模块导入

模块的导入应该从包导入到模块级别，而不是直接导入到方法级别。

``` python

from datetime import datetime

print datetime.now()

```

如果直接从模块中导入的话，那么应该起一个别名，加上前缀或者是直接导入该模块：

``` python
from game import play as game_play

game_play('cheese')

# import game
# game.play('cheese')

```

需要达到的效果就是，让别人能够知道你的这个方法或者对象是从那个模块中来的，用以区分对象。

**6**. 抛出异常

异常的抛出应该使用新建异常对象的方式，不要使用序列来管理异常：

``` python

try:
    pass
except Exception, e:
    pass
else:
    pass
finally:
    pass

```

只对需要处理的异常进行捕获，这些异常是你比较确定的切需要你来处理的，不要试图使用excep捕获所有的异常，
这样通常容易产生漏洞或者很难找出那里处理问题。对于需要关闭的如文件, IO最好使用finally关键字来包裹代码，
这样可以防止那些未经捕获的异常发生时对系统资源的过量占用。

**7**. 嵌套与作用域的问题

在python中推荐使用函数和类嵌套定义来限制作用域，这样可以让代码结构更加清晰，容易理解，这些作用域一方面限制了
代码的可见范围，另一方面也减少了出现风险的可能性，让设计更加的准确。

**8**. 列表推导

python 中有很多很酷的操作，比如说列表推导和条件运算，但是这些往往也可能会造成很多的困扰，他们大多用在比较简单
的情况中，并不能因为可以减少代码量就使用它们，这样会增加代码的阅读难度，换来的价值不多。

``` python

flag = False if x == 0 else True

items = [x*3 for x in [1, 2, 3]]

```

**9**. 迭代器的使用

python 中迭代器可以很方便的动态计算所需要的值，我们所创建的迭代器只是返回值的生成规则，迭代器在运行过程中
会记录自己本地变量的状态。

``` python
def fibonacci():
    a, b = 0, 1
    while True:
        yield b
        a, b = b, a+b

print fibonacci.next()

```

这里虽然有循环在函数内部，但是由于使用了`yield`关键字，所以他实际上是一个迭代器，每次枚举的时候才进行一次
的计算，中间的while循环只是代表了这是一个可以无限枚举的迭代器。每次枚举过后，迭代器会自行记录当前a,b的状态值。


**10**. 关于map, filter, reduce

python中建议使用map, filter, reduce来进行批处理与计算。这些函数的效率很高，类似于java中的流操作，使用这些
函数在不影响阅读性的前提下推荐使用。

**11**. lambda函数

单行函数建议使用lambda来代替，可以提高代码的阅读性。


**12**. propery

- 只读属性应该使用property来创建
- 访问和设置类成员的时候应该使用propery来创建

# 安全编码规范

**1**. 在页面上打印未知的东西一定要进行编码

``` python

import sys

print sys.stdout.encoding

# support system default encoding is: ascii
print '\x34'    # try to match ascii code

print u'\xe9'   # convert unicode to ascii code

print u'\xe9'.encode('latin-1')     # just match the system encode

```

**2**. SQL语句不要使用拼接的方式

``` python
# 使用sqlite3查询插入语句

import sqlite3

db = sqlite.connect('filename.db')

cursor = db.cursor()

# try to use ? wildcard to represent data or use python
# string.format() to deal with replacement
sql = """
      INSERT INTO {0}(Description)
      VALUES (?)
      """.format(table_name)

cursor.execute(sql, (description, ))

db.commit()
db.close()

```

**3**. 执行外部命令，一定要对命令和参数做安全验证和处理

``` python

# 验证参数的正确性
# 用户调用是否安全

def schedule(command, params):
    """run a command through API on the real machine

    run a command on the common machine which is a real remote
    machine, some data meybe critical.

    Args:
        command(str): a shell command or a program to run
        params(tuple): the params which will be used by the command

    Returns:
        str: the program result data

    Raise:
        ValueError: params type error.
        NotAllowed: some commands are not allowed to run on the
            server.
    """

    ALL_COMMANDS = (a, b, c, d, e, f, g, h)

    if command not in ALL_COMMANDS:
        raise NotAllowed('Command: {0} is not allowed to run on the server'.format(command))

    if not isinstance(params, tuple):
        raise ValueError('second params should be a tuple type.')

    return command(**params)
```

**4**. 让用户输入路径要小心谨慎


# 参考

1. [Google Docstring](http://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html)
2. [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
