1. 生成程序过程：

    编译：根据源文件生成中间目标文件（o文件或者obj文件）
    链接：根据中间目标文件生成可执行文件，在大多数时候，由于源文件太多，编译生成的中间目标文件太多，而在链接时需要明显地指出中间目标文件名，这对于编译很不方便，所以，我们要给中间目标文件打个包，在Windows下这种包叫“库文件”（Library File)，也就是 .lib 文件，在UNIX下，是Archive File，也就是 .a 文件

2. makefile规则：

        target...:prerequisites...
            command
            ...
            ...
        .PHONY : clean 
        clean : 
            -rm edit $(objects)

    一定要以一个Tab键作为开头 

3. makefile原理：
    prerequisites中如果有一个以上的文件比target文件要新的话，command所定义的命令就会被执行。这就是Makefile的规则。也就是Makefile中最核心的内容。

4. 变量：

        objects = main.o kbd.o command.o display.o \ 
            insert.o search.o files.o utils.o

5. 引用：$(objects)

6. 格式：

    可执行文件 : 相关的好几个目标文件（作用是将这些文件链接起来，生成可执行文件）

    然后，每个实现文件，要生成对应的目标文件

    目标文件 : 一个实现文件 与之相关联的h头文件

    如下：

        test : test.o fraction.o ZeroDivisionException.o
          g++ -o test test.o fraction.o ZeroDivisionException.o

        test.o : test.cc fraction.h
          g++ -Wall -g -c test.cc

        fraction.o : fraction.cc ZeroDivisionException.h
          g++ -Wall -g -c fraction.cc

        ZeroDivisionException.o : ZeroDivisionException.cc
          g++ -Wall -g -c ZeroDivisionException.cc

        clean:
          rm -rf *.o test *.exe

7. gcc 编译选项：

        -x language 指定文件所使用的语言--c, objective-c, c-header, c++, assembler等
        -x none 关闭上一个语言选项，让gcc自动根据文件名后缀识别文件类型
        -c  做预处理、编译、汇编，生成中间文件obj文件（.o文件）
        -S  做预处理、编译，生成汇编代码（.s文件）
        -E  做预处理，不生成文件，可以重定向到一个输出文件里
        -o  指定生成文件的名字
        -g  只是在编译的时候，产生调试信息
        -I dir  搜索dir目录中的头文件
        -L dir  搜索dir目录中的库文件
        -static 链接静态库
        -library  链接名为library的库文件
        -w  关闭所有告警
        -Wall 允许发出gcc提供的所有有用的报警信息
