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

在python中如果需要绑定类属性的话，只需要把属性绑定在`self`关键字上面，如果一个方法是类方法的话，也可以申明self为方法的第一个参数，那么会绑定到类上面，注意类方法具有相同的偏移量，都只对类可见。

上面的类中描述了`Person`这个类拥有两个属性`name`、`age`，拥有两个类方法`get_name`、`get_age`，其中`__init__`和`__del__`分别是构造函数和析构函数，在类初始化的时候和销毁的时候被自动调用。

``` python

>>> someone = Person("Json", 32)  # 调用__init__
>>> del someone                   # 调用__del__

```

这个是程序的机制，是附加方法帮助类实现初始化和销毁的，对象的生命周期是从类初始化的时候开始的，当对象被销毁的时候对象的生命周期就结束了。

# 常见数据结构

在python中有很多常见的数据结构都是直接可用的，具体的包括：

- 元组
- 数组
- 字典
- 队列
- 栈

## 元组

元组是不异变类型，当丁以后只能够访问其中的元素，没法改变元组中的元素了：

``` python
>>> a = ("red", "green", "blue")
>>> print a[0]
>>> print a[1]
```

元组的定义是以`()`来定义的，定义之后就只能够访问了，不能够追加元素到元组中，也不能通过索引修改元组的值，注意元组可以存储不同的类型的对象。

## 数组

数组可以用来存储对象，注意python中一切皆是对象，所以python数组也是相当灵活的，数组中的元素可以是不同的类型。
数组支持的操作：

- 追加append， 被append的对象将会被当作对象append
- 扩展extend，将其他数组的元素扩展到当前数组
- 索引，通过下标访问
- 切片，通过[start:end]来控制
- 删除元素, `del`

``` python
>>> a = []              # 定义数组
>>> a.append("one")     # 追加元素'one'
>>> a.append("two")     # 追加元素'two'
>>> a.append(3)         # 追加元素3， 整数类型
>>> b = [4, 5, 6]       # 定义数组并初始化为4, 5, 6
>>> a.append(b)         # 将数组[4, 5, 6]整体作为对象追加到a中
>>> a.extend(b)         # 分别将b中的4， 5， 6取出来添加到a数组中
>>> a + b               # 将两个数组连接起来
>>> print a[0]          # 打印a中的第一个元素
>>> print b[1:3]        # 打印b中的1-3号元素
>>> del a[0]            # 删除a中的第一个元素
```

## 字典

字典也可以简单认为是hash表，hash与对象对应关系，简单的表结构如下：

|hash key        |value |
|---             |---   |
|name            |Jhon  |
|age             |32    |
|address         |sun road 114|

对应的存储结构很容易存储一一对应的场景，比如对象的存储可以使用这样的存储结构：

``` python 

>>> a = {}
>>> a["name"] = "Jhon"
>>> a["age"] = 32
>>> a["address"] = "sun road 114"
>>> a.keys()        # show all keys
>>> a.values()      # show all values
>>> a.items()       # show key, value tuples
>>> del a['age']    # 删除age值
```

## 更加丰富的数据结构

在python中很多的数据结构都是包含在官方的包中的，需要引入相应的数据包才能使用对应的数据结构，就比如队列来说吧：

队列是一种先进先出的数据结构，常见于任务队列，在生活中所有跟排队相关的都可以认为是队列的高度抽象，来看一个简单的队列使用的例子：

``` python

>>> from collections import deque

>>> queue = deque()             # 创建队列
>>> queue.append("a")           # 排队
>>> queue.append("b")           # 排队
>>> queue
deque(['a', 'b'])
>>> queue.pop()                 # 从队尾取出一个元素
'b'

>>> from collections import deque
>>> queue = deque()
>>> queue.append("a")
>>> queue.append("b")
>>> queue.popleft()             # 从队头取出一个元素
'a'

```

我们这里利用`deque`数据结构可以实现两种常见的数据结构队列和栈，队列和栈的区别是队列是先进先出的，而栈是后进先出的。
