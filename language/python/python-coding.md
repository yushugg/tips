字符编码简介：
ASCII
  单字节编码，\x80以下
MBCS
  \x80以上
  IBM发明的Code Page的概念，如GBK是第936页，也就是CP936
  目前为止，用的都是双字节，所以有时候也叫DBCS
  MBCS不是某一种特定的编码，Windows中的ANSI，指的也是GBK
Unicode
  仅仅是字符对应码位的一张表而已，字符具体如何传输和存储则是由UTF来负责

Python2.x编码问题
  str:字节串，Unicode经过编码后的字节组成的序列，如对utf-8编码的str‘汉’使用len，结果是3
  unicode:真正的字符串，len(u'汉') == 1

  **unicode是中间编码**
  unicode--encode-->str s = u.encode('utf-8')
  str--decode-->unicode u = s.decode('gbk')
  注意存入文件中的是str，所以读取文件要str decode，写文件要encode成str
  存入文件的是字节流，即str
  **建议处理的时候，都是unicode，存的时候再转成str**

  在源文件中，如果遇到非ASCII字符，需要在文件头进行字符编码声明
  如下：
    #-*- coding: uft-8 -*-
    python只检查#，coding和编码字符串，其他的无所谓

Some tips:
  1. 同一工程中所有源代码文件使用相同的字符编码声明
  2. 如果有一些编码问题，要抛弃str，处理过程中全部使用unicode
  3. 避免字符编码：MBCS, DBCS, UTF-16

  注意str是字节串！！！
