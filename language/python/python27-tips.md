前两行，执行的程序和编码
#! /usr/bin/env python
#-*- coding:utf-8 -*-
如此，source文件中可以写中文等Unicode文字，如print "您好"

docstring:
    第一行为函数解释
    第二行空
    第三行为具体内容
    func.__doc__

A value can be assigned to several variables simultaneously:
e.g.  x = y = z = 0
      a, b = b, a+b

类型：
numbers--int, float, complex
    complex--
        后面跟一个j或者J, 9+3j
        或者由complex(real, imag)来创建, 不需要import什么库
        两部分都是float
        读取两部分使用z.real, z.imag
        读取模的大小使用abs(z)
strings--immutable!!!
    print string结果是没有外层的引号的
    直接输string，则输出的是带引号的string值
    repr和``作用都是输出带引号的string值
    ''''''为多层string，r开头为raw string，u开头为Unicode string
    xxstr.encode('coding')-->编码成字节流
    xxstr.decode('coding')-->解码成字符流
    raw_input:输入string的时候不用加引号
    input:输入string的时候要加引号

range(start, end+1, step)
for index, value in enumerate(xx)
for q, a in zip(questions, answers)

*arg: list
**arg: dict
如果已有一个list或者dict，调用函数可以用*or**来解压此list或dict
lambda x, y:x+y    冒号前面x, y为函数参数，冒号后面x+y为函数返回值

Data Structures:
list
    插入--list.append(x)
          list.extend(L)
          list.insert(i, x)
    删除--list.remove(x)
          list.pop([i])  无i则删除最后一个，并返回最后一个
    查询--list.index(x)  查询x的下标
    函数--list.count(x)
          list.sort()
          list.reverse()
    [abs(x) for x in vec if x >= 0]最前面为返回值
tuple
set  空set为set()
dict 空dict为{}

