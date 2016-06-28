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
