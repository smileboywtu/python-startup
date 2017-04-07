# 变量

在Python中一切皆是对象，这句话是掌握好Python的核心，我们常见的编程的基本元素有：

- 变量（Veriable），如a，b，c
- 函数（Function）, def main(a, b)
- 类（class）, class Animal(object)
- 包（package）
- 库（module）

这些在Python中都可以理解为对象，对象可以赋值给变量存储和传递，一切都要追踪到Python是一门动态语言，这让我们写起代码来很简单，可以动态的替换部分模块，动态加载代码和库。

在python中定义变量很简单，不需要申明类型，只需要申明变量名称，变量的值可以是任何类型，这些都是动态决定的。

``` python

a = 1                       # 整型
b = {}                      # 字典
c = []                      # 数组
d = lambda x: x * x         # 方法，lambda表达式
e = "python is dynamic"     # 字符串
f = 'python is dynamic'     # 字符串
g = """string can span to 

multi-line"""               # 字符串

>>> print e
>>> print f
>>> print g

```

在python中注释用`#`开头，如果你要书写多行注释，你可以使用`#`分别注释每一行,当然你也可以使用`''' ... '''`，与string表示是类似的。

在python中字符串的表示有三种方式：
``` python

str1 = "hello, world"
str2 = 'hello, world'
str3 = """hello, world"""
```
上面三种其实是等价的，都可以表示字符串，但是单双引号的区别并不是很大，主要是单双引号与三引号的区别有点大，当字符串写在多行的时候，往往需要格式化输出一个图形的字符串，三引号所见即所得，与程序里面的布局是一样的，而单双引号表示的时候是有难度的，并不是那么容易，换句话说单双引号表示的是单行字符串，当然也可以写在多行，但是输出的是单行：

``` python

>>> a = "one two three"
>>> b = (
...     "one "
...     "two "
...     "three"
... )
>>> a
'one two three'
>>> b
'one two three'

>>> c = """
...  ____
... / ___| _   _ _ __   ___ _ __
... \___ \| | | | '_ \ / _ \ '__|
...  ___) | |_| | |_) |  __/ |
... |____/ \__,_| .__/ \___|_|
...             |_|
... """
>>> print c
'''
 ____
/ ___| _   _ _ __   ___ _ __
\___ \| | | | '_ \ / _ \ '__|
 ___) | |_| | |_) |  __/ |
|____/ \__,_| .__/ \___|_|
            |_|
'''
```

如果你使用单双引号的话，你很难实现三引号的效果。

`变量`只需要注意变量可以存储任何对象，变量要以字母或者下划线开头，不能以数字开头，长度不要超过255字符。

# 方法

由于python是一门面向对象的编程语言，所以方法（function）在这个语言中有两个含义，这里需要简单区分下：

- function: 一般是在类外面，与method的类似，函数的定义也是类似的
- method: 一般是指类或者对象的方法，有明确的作用域，属于类的一部分

``` python

def say_hello(name):
    """say hello to someone

    :param name: string , name
    :return str: greeting string
    """
    return "hello", name

class Person(object):
    """Person class """

    def __init__(self, name):
        self.name = name

    def greeting(self, name):
        """greet to someone"""
        return "hello, ", name, "I'm ", self.name
```

这里`say_hello`和`greeting`都是function，但是我们说`greeting`是method，主要原因是greeting是类方法，是Person类的一部分，其他类无法使用这个方法。

这里我们可以看到在`python`中我们不需要申明参数的类型，也不用强调返回值的类型，一切都是动态的，这得益于python的动态语言特性，但是这也会造成程序的不严谨，所以我们需要写好注释，方便别人正确使用我们的类库。

# 代码段

在python中，代码段的控制是通过对齐来划分的，像上面我们定义一个程序段，写在function里面：

``` python

def func1(a, b):
    """func1"""
    def func2(a, b):
        return a + b
    return func2(a, b)

def func3(a, b):
    return func1(a, b)

```

这个地方func1和func3是一个作用域里面的，互相可见，但是func2只对func1可见，对func3不可见，这就是作用域的关系，一般我们使用`4个空格`来划分一个作用域，拥有相同偏移量的代码成为一个代码段，这个代码只对它的父级作用域可见，这很像c语言中的`{}`。

# 类

面向对象的设计语言中，都包含类的概念，类作为对象的容器，没有类对象很难有载体，可以认为类是对象的蓝图。

``` python

class Person(object):
    """Person class"""

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def get_name(self):
        return self.name

    def get_age(self):
        return self.age

    def __del__(self):
        self.name = None
        self.age = None

```

对象有三个方面的东西： `属性`、`方法`、`生命周期`。
类是用来描述对象的模版，通过实例化类我们可以得到对象，但是针对每个对象，都是有其生命周期的，伴随着软件有自己的存活期。