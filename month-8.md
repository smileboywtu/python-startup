# 面向对象的编程思想

面向对象编程——Object Oriented Programming，简称OOP，是一种程序设计思想。OOP把对象作为程序的基本单元，一个对象包含了数据和操作数据的函数。

面向过程的程序设计把计算机程序视为一系列的命令集合，即一组函数的顺序执行。为了简化程序设计，面向过程把函数继续切分为子函数，即把大块函数通过切割成小块函数来降低系统的复杂度。

而面向对象的程序设计把计算机程序视为一组对象的集合，而每个对象都可以接收其他对象发过来的消息，并处理这些消息，计算机程序的执行就是一系列消息在各个对象之间传递。

## 面向过程示例

``` c

#include "stdio.h"

struct Student {
    char* name;
    int age;
    char* address;
}

char* get_name(struct Student someone) {
    return someone.name
}

int get_age(struct Student someone) {
    return someone.age
}

char* get_address(struct Student someone) {
    return someone.address
}

// show student
void main(void) {
    struct Student someone = {"John", 32, "sun road 114"};
    printf("name: %s\n", get_name(someone))
    printf("age: %d\n", get_age(someone))
    printf("address: %s\n", get_address(someone))
}

```
通过定义结构体，创建包含有对象属性的集合，然后通过额外的方法体来操作集合，方法体和集合之间存在若关系对。

## 面向对象示例

``` python

class Student:
    """show Student information"""

    def __init__(self, name, age, address):
        """init the student information"""
        self.name = name
        self.age = age
        self.address = address

    def get_name(self):
        return self.name

    def get_age(self):
        return self.age

    def get_address(self):
        return self.address

if __name__ == "__main__":
    someone = Student("John", 32, "sun road 114")
    print "name: ", someone.get_name()
    print "age: ", someone.get_age()
    print "address: ", someone.get_address
```
面向对象的编程过程中，对象的方法和属性封装在同一个集合中，不像面向过程那么的松散，方法和属性的关系更加紧密。

## 面向对象和面向过程对比

`面向过程`是一种以事件为中心的编程思想。就是分析出解决问题所需要的步骤，然后用函数把这些步骤一步步实现，使用的时候一个个依次调用。

`面向对象`是一种以事物为中心的编程思想。将数据和对数据的操作放在一起，作为一个相互依存的整体，就是所谓的对象。对同类对象抽象出其共性，就是类，类中的大多数数据只能被本类的方法进行处理。类通过一个简单的外部接口与外界发生关系，对象与对象之间通过消息进行通信。

面向过程其实是最为实际的一种思考方式，就是面向对象的方法也是含有面向过程的思想。可以说面向过程是一种基础的思想，它考虑的是实际的实现。一般的面向过程是从上往下步步求精，所以面向过程最重要的是模块化的思想。对比面向对象，面向对象的方法主要是把事物给对象化，对象包括属性和行为。当程序规模不是很大时，面向过程的方法还会体现出一种优势，因为程序的流程很清楚，按着模块与函数的方法可以很好的组织。
