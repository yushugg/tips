re
    match、search、findall，参数pattern、string、flag=0
    match -- 从开头开始匹配，^
    search -- 从任意位置开始匹配，含有括号的则为一组
    findall -- 匹配所有的，match和search只要匹配到了一个就停止，并且返回一个list，而不是拥有group的那个对象

    split(pattern, string, maxsplit=0, flags=0)
    sub(pattern, repl, string, count=0, flags=0)

    re.compile(pattern)
    之后的调用上述函数，参数省去pattern，直接用string、flag即可

    \b -- 非字符的空串，放在一个单词的开始或者结尾，如r'\bfoo\b'matches'foo','foo.','(foo)', but not 'foo3','foobar'
    \B -- 与\b正好相反，如r'py\B'matches'python','py3', but not 'py','py.','py!'
    \d -- 数字
    \D -- 非数字
    \s -- 空白符
    \S -- 非空白符
    \w -- 单词，[a-zA-Z0-9_]
    \W -- 非单词
    . -- 任意字符，除了newline
    ^ -- 开始
    $ -- 结束
    * -- 0或更多
    + -- 1或更多
    ? -- 0或1
    {m} -- m次
    {m, n} -- m到n次     {m, n}?都匹配时，选择最小的
    | -- 或者
    (...) -- 一个组，方便在search和match查看group
    [...] -- 匹配其中的一个字符

生成器，迭代器
    yield 暂停一个函数，next()从其暂停处恢复其运算
    第一次调用含有yield的函数不会运行，只是初始化，当第一次调用next(xx)后，才会运行函数，并在yield处停下
    或者在for循环之类的直接使用，每次for循环将会自动调用next()函数，从函数生成器中获取数值，并赋值给for循环索引变量

    类里面__iter__，__next__，分别对应iter(..)和next(迭代器)不需要用yield了，而用return代替
    raise StopIteration
    iter = iter(class)得到一个迭代器iter，之后每次调用next(iter)即可迭代了
    iter获得迭代器，next获取下一个元素，两个都要有

    *************************
    生成器使用于将一个函数变成可以迭代的迭代器，通过yield来产生下一个值
    而迭代器自己可以迭代，并且有自己的next方法
    *************************

文件
    先打开，open(filename, mode, encoding, ...)
    注意字符和字节
    seek(x) -- 移动到第x个字节
    read(y) -- 读取y个字符
    tell() -- 返回当前字节位置
    最后close()

    推荐使用with open(...) as file:
    对于b二进制方式读取，就没有encoding的概念了，而且read读取的是按字节来计数的

XML
    xmlns -- namespace
    tree = ET.parse('xx.xml')
    root = tree.getroot()

    root[i] -- 第i个子集，子集为列表
    root.attrib -- 属性值，为字典
    text -- 内容

    查找，用find或者findall，要带上名字空间
    格式为{namespace}属性名

序列化
    pickle模块
    pickle.dump(entry, f)
    entry为数据结构，f为要保存在的文件，已经open as f, 二进制的形式

    读取方式
    entry = pickle.load(f), 已经open as f，二进制形式

    注意流中的s
    dump到二进制流中，b = pickle.dumps(entry)
    load出来，entry2 = pickle.loads(b)

    json模块
    json.dump(entry, f)
    文本格式的打开
    entry = json.load(f)
    文本格式的打开
