## Built-in Functions

1. abs(x)

    返回一个number的绝对值，number可以是整形、浮点、complex(返回长度)

2. all(iterable)

    如果所有元素True，则返回True（空，返回True）

3. any(iterable)

    如果所有元素False，则返回False（空，返回False）

4. bin(x)

    将一个int转成二进制的string，如果x不是int，则需要定义__index__()方法返回一个int

5. bool([x])

    将x值转成布尔类型，即返回True或者False

6. callable(object)

    如果object是callable的，则返回True，否则返回False；

    如果返回True，仍然可能call失败，但是如果是False，则一定失败

7. chr(i)

    返回整型i的一个字符组成的字符串，chr(97)返回'a'
8. classmethod(function)

    使用方法如下：

        class C(object):
          @classmethod
          def f(cls, arg1, arg2, ...):
            ...

    此语法糖相当于classmethod(f)

    @staticmethod不需要表示自身对象的self和自身类的cls参数，和普通函数一样，如果要调用类的属性和方法，则需要用类名.属性名或者类名.方法名来操作，灵活性不够，和一个全局函数相同

    @classmethod不需要self参数，但是第一个参数需要是表示自身类的cls参数，灵活性更大，可以用cls参数调用类的属性、方法、实例化对象等

9. cmp(x, y)

    比较两个对象x和y，返回一个int，如果x<y，返回负数；如果x==y，返回0；如果x>y，返回正数

10. complex([real[, imag]])

    复数real + imag*j

11. delattr(object, name)

    等于del object.name，name是个str

12. dir([object])

    如果没有参数，返回当前local scope的names；有一个参数，返回object的有效属性list

13. enumerate(sequence, start=0)

    返回一个tuple，包含一个count和对应的value

14. eval(expression[, globals[, locals]])

    globals和locals是字典，执行python语句expression

15. execfile(filename[, globals[, locals]])

    解析一个file

16. filter(function, iterable)

    创建一个list，等于[item for item in iterable if function(item)]

17. getattr(object, name[, default])

    等于object.name

18. hasattr(object, name)

19. help([object])

20. hex(x)

    将int数字转换成0x开头的小写字母字符串

21. isinstance(object, classinfo)

22. issubclass(class, classinfo)

23. iter(o[, sentinel])

24. len(s)

    s的长度

25. map(function, iterable, ...)

26. max(iterable[, key])

        max(arg1, arg2, *args[, key])
        min(iterable[, key])
        min(arg1, arg2, *args[, key])

    key指定一个排序的函数, max(a, b, c, key=func)

27. next(iterator[, default])

28. oct(x)

    将整型数字转成octal string

29. open(name[, mode[, buffering]])

30. pow(x, y[, z])

31. print(\*objects, sep='', end='\n', file=sys.stdout)

32. range(stop)

    range(start, stop[, step])

33. raw_input([prompt])

34. reduce(function, iterable[, initializer])

35. reload(module)

36. repr(object)

37. reversed(seq)

38. zip([iterable, ...])

    取小的len来整合

## re

1. re.compile(pattern, flags=0)

2. re.search(pattern, string, flags=0)，查找第一个匹配的

3. re.match(pattern, string, flags=0)，从头开始匹配

4. re.split(pattern, string, maxsplit=0, flags=0)

5. re.findall(pattern, string, flags=0)，返回list

6. re.sub(pattern, repl, string, count=0, flags=0)

7. group([group1, ...])

        m = re.match(r"(\w+) (\w+)", "Isacc Newton, physicist")
        m.group(0)  #'Isaac Newton'
        m = re.match(r"(?P<first_name>\w+) (?P<last_name>\w+)", "Malcolm Reynolds")
        m.group('first_name') #'Malcolm'

8. groups([default])

    	m.groups()
    	返回一个tuple


## datetime


## heapq


