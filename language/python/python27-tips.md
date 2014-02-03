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
      同时赋值的，先计算完右边的，然后同时赋给左边对应的变量

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
    str()返回human readable的值

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
反之，解压：如果已有一个list或者dict，调用函数可以用*or**来解压此list或dict
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

Modules:
from xx import *:
导入除了下划线（__）开头的所有的item

dir(xx):xx module的所有name;如果xx为空，则显示当前可用的name
查看builtin的name，先import __builtin__，然后dir(__builtin__)

sys:
    sys.ps1, sys.ps2--提示符>>>和...
    sys.path--读取PYTHONPATH环境变量
    sys.stdin, sys.stdout, sys.stderr
    sys.argv

os:
    os.getcwd
    os.chdir('xxx')
    os.system('mkdir yy')--执行命令

Package:
    结构：
        一个大的文件夹下，每个文件夹下都要有个__init__.py
        该文件中可以定义__all__变量，一个list，交代当from package import *的时候，导入的name是哪些
        __init__.py
        xx/
            __init__.py
            xx.py
            ...
        yy/
            __init__.py
            yy.py
            ...
        zz/
            __init__.py
            zz.py
            ...

Input and Output:
    旧的string format为 print 'xx %s' % x

    print 'xx {} xx {}'.format(x, y)
    print 'xx {a} xx {b}'.format(a=x, b=y)
    冒号用来精确定义一些, print 'xx {0:.3f}'.format(x)
    也可以print 'xx {0[1]:d}'.format(x)当列表等使用，d为type 整型
    {0!s}调用str()，{0!r}调用repr()

    读写文件：(read, seek都为字节，python3中read为按字符，规定了编码的话)
        f = open(filename, mode)
        f.read(size)
        f.readline()读取一行
        f.readlines()

        f.write(string)
        f.writelines(xx)
        没有writeline函数

        f.seek(num, start)--num 定位到从start开始的第num字节处, start 0开头，1当前位置，2末尾
        f.tell()--告知当前的位置在哪儿

        使用with as语句最好，python27也可以使用

        编码--encode，decode([encoding], [errors='strict'])可设成ignore

Exceptions:
    try except Exception as e:
    raise Exception
