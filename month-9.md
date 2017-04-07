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

# 运算符

运算符是程序做运算的基本连接符，最基本的运算符就是加、减、乘、除，但是除了这些python还提供了丰富的操作符，当多个操作符在一起的时候，
就需要注意操作符的优先级问题了。

|运算符  |描述  |
|---     |---   |
|**      |指数 (最高优先级)|
|~ + -   |按位翻转, 一元加号和减号 (最后两个的方法名为 +@ 和 -@)|
|* / % //|乘，除，取模和取整除|
|+ -     |加法减法|
|>> <<   |右移，左移运算符|
|&       |位 'AND'|
|^ \|     |位运算符|
|<= < > >=|比较运算符|
|<> == != |等于运算符|
|= %= /= //= -= += *= **=|赋值运算符|
|is is not|身份运算符|
|in not in|成员运算符|
|not or and|逻辑运算符|

有时候我们要进行运算的时候，我们就需要注意各个运算符的含义，已经多个运算符同时出现时，他们的优先级是什么样的。

常见运算符分类：

- 算术运算符： +, -, \*, /, %, //, \*\*
- 比较运算符： <=, <, >, >=, <>, ==, !=
- 位运算符：&, |, ^, -, <<, >>
- 逻辑运算符： and, or, not
- 身份运算符： is, is not
- 成员运算符： in, not in

``` python

>>> a = 20
>>> a += 2
>>> a
22
>>> a -= 1
>>> a *= 2
>>> a
42
>>> a /= 2
>>> a
21
>>> 2 ** 4
16
>>> a % 3
0
>>> a // 4
5
>>> a / 4
5
>>> a / 4.0
5.25

```

## 关于位运算

位运算是计算机底层依赖的运算机制，可以说我们常见的算术运算都可以通过位运算来完成。
位运算主要的操作符有: `&, |, ^, >>, <<`

在介绍位运算之前，我们需要知道什么是二进制表示形式，要讲到二进制，那么我们需要先从常见的十进制和
十六进制开始说起，我们先来谈谈我们常见的十进制，所谓的十进制就是：逢十进一。
>>> 
    15 = 1 * 10 + 5
    23 = 2 * 10 + 3
    103 = 1 * 10^2 + 0 * 10 + 3
    1024 = 1 * 10^3 + 0 * 10^2 + 2*10 + 4
    十进制是由0-9组成的，只能出现比10小的数字

我们在看看十六进制，与十进制类似是：逢十六进一。
根据前面十进制的类推， 十六进制只能出现比16小的数字，那么问题出现了，像10， 11， 12 ... 这种在116进制
中如何表示，真不能用两位吧，这样人们就想到了使用A-F来表示10-16之间的数字。

|十进制 | 十六进制 |
|---    |---       |
|10     |A         |
|11     |B         |
|12     |C         |
|13     |D         |
|14     |E         |
|15     |F         |

>>>
    0xEF = E * 16 + F = 14 * 16 + 15 = 239
    0x12 = 1 * 16 + 2 = 18

那么我们很快的可以推算出二进制的形式了：逢二进一。
并且二进制的表示中只能出现0和1。

>>>
    0B11 = 1 * 2 + 1 = 3
    0B1101 = 1 * 2^3 + 1 * 2^2 + 0 * 2 + 1 = 11

我们所的位运算就是针对二进制推出的一种算法符，常见运算符含义如下：

``` python
# & , 同真则真
>>> 0 & 1
0
>>> 1 & 1
1
>>> 1 & 0
0

# |, 有真则真
>>> 1 | 0
1
>>> 0 | 1
1
>>> 1 | 1
1
>>> 0 | 0
0

# ^, 不同则真
>>> 1 ^ 0
1
>>> 0 ^ 0
0
>>> 1 ^ 1
0

>>> 0b1101 & 0b1111
13
>>> 0b1101
13

>>> 0b1101 | 0b1111
15
>>> 0b1111
15

>>> 0b1101 ^ 0b1111
2                  
>>> 0b0010         
2                  
```

还有两个很特别的运算符，就是位移运算符，位移运算符不需要做太复杂的运算，但是有运算技巧需要记忆。

其中`>>`运算符将所有二进制位右移位，前面补充0值。
而`<<`运算符是相反的，将所有的二进制位左移位，后面补充0值。

``` python
>>> a = 0b1110 >> 1
>>> bin(a)
'0b111'

>>> a = 0b111 << 1
>>> bin(a)
'0b1110'

>>> a = 0b111 << 2
>>> bin(a)
'0b11100'
```

## 关于逻辑运算符

所谓的逻辑运算符就是为了并列条件来用的，比如我要干一件事情，其中有几个要素，我需要同时满足多个要素的时候用`and`，
如果我只是需要其中一个要素满足的时候用`or`， 或者我需要反向条件的时候，可以使用`not`：

``` python
def divition(a, b):
    if a == 0 or b == 0:
        return 0
    if not b and a:
        return a / b 
```

逻辑运算符常见于条件组合判断。


## 身份运算符

判断是不是同一个类型的时候：

``` python
>>> type(2) is int
True
>>> type("hello") is str
True
```

## 成员运算符

判断某个元素是不是一个集合的成员：

``` python
>>> 3 in (1, 3, 4)
True
>>> 3 in [1, 32, 34, 3]
True
>>> "name" in {"name": "Json", "age": 12}
True
```

# 包和库

包是库的集合，库可以简单的看作是一个py文件，库名字就是py文件的名字：

定义一个python文件`hello.py`,

``` python
# hello.py

name = "Jhon"
age = 32
address = "sun road 114"
```

然后在同一目录下面启动python解释器， 直接`import`这个库：

``` python
>>> import hello
>>> dir(hello)
['__builtins__', '__doc__', '__file__', '__name__', '__package__', 'address', 'age', 'name']
>>> hello.name
'Jhon'
>>> hello.age
32
>>> hello.address
'sun road 114'
```

在一个文件夹下定义多个库，并且包含`__init__.py`文件，那么这个文件夹就是一个包，文件夹的名字就是包名。

``` shell
$ ls generic/
__init__.py  hello.py
```

这里我们简单定义了一个包， 包名是`generic`，这个包中含有`hello`库。


# 简单的Python项目

## 猜数字游戏

写一个猜数字脚本，当用户输入的数字和预设数字（随机生成一个小于100的数字）一样时，直接退出，否则让用户一直输入，并且提示用户的数字比预设数字大或者小。

``` python
#!/usr/bin/env python
import random


guess = 0
tries = 0
secret = random.randint(1,100)

print "This game is to guess a number for you!"
print " It is a number form 1 to 99, I'll give you 6 times to try. "

while guess != secret and tries < 6:
    guess = input("Please input your guess number: ")
    if guess < secret:
        print "====Your guess is too low !====\n"
    elif guess > secret:
        print "====Your guess is too high!====\n"
    tries = tries + 1

if guess == secret:
    print "Congratulations to you! Your  guess is right ! "
else:
    print "No more guesses! Better luck next time for you!"
    print "The secret number was", secret
``` 

## TIC TOC 游戏

三连棋游戏(两人轮流在印有九格方盘上划“+”或“O”字, 谁先把三个同一记号排成横线、直线、斜线, 即是胜者)，可以在线玩

``` python
def print_board(board):

    print "The board look like this: \n"

    for i in range(3):
        print " ",
        for j in range(3):
            if board[i*3+j] == 1:
                print 'X',
            elif board[i*3+j] == 0:
                print 'O',  
            elif board[i*3+j] != -1:
                print board[i*3+j]-1,
            else:
                print ' ',
            
            if j != 2:
                print " | ",
        print
        
        if i != 2:
            print "-----------------"
        else: 
            print 
            
def print_instruction():
    print "Please use the following cell numbers to make your move"
    print_board([2,3,4,5,6,7,8,9,10])


def get_input(turn):

    valid = False
    while not valid:
        try:
            user = raw_input("Where would you like to place " + turn + " (1-9)? ")
            user = int(user)
            if user >= 1 and user <= 9:
                return user-1
            else:
                print "That is not a valid move! Please try again.\n"
                print_instruction()
        except Exception as e:
            print user + " is not a valid move! Please try again.\n"
        
def check_win(board):
    win_cond = ((1,2,3),(4,5,6),(7,8,9),(1,4,7),(2,5,8),(3,6,9),(1,5,9),(3,5,7))
    for each in win_cond:
        try:
            if board[each[0]-1] == board[each[1]-1] and board[each[1]-1] == board[each[2]-1]:
                return board[each[0]-1]
        except:
            pass
    return -1

def quit_game(board,msg):
    print_board(board)
    print msg
    quit()

def main():
    
    # Start Game
    # Change turns
    # Checks for winner
    # Quits and redo board
    
    print_instruction()

    board = []
    for i in range(9):
        board.append(-1)

    win = False
    move = 0
    while not win:

        # Print board
        print_board(board)
        print "Turn number " + str(move+1)
        if move % 2 == 0:
            turn = 'X'
        else:
            turn = 'O'

        # Get player input
        user = get_input(turn)
        while board[user] != -1:
            print "Invalid move! Cell already taken. Please try again.\n"
            user = get_input(turn)
        board[user] = 1 if turn == 'X' else 0

        # Continue move and check if end of game
        move += 1
        if move > 4:
            winner = check_win(board)
            if winner != -1:
                out = "The winner is " 
                out += "X" if winner == 1 else "O" 
                out += ""
                quit_game(board,out)
            elif move == 9:
                quit_game(board,"No winner")

if __name__ == "__main__":
    main()

```