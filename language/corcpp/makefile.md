生成程序过程：
    编译：根据源文件生成中间目标文件（o文件或者obj文件）
    链接：根据中间目标文件生成可执行文件，在大多数时候，由于源文件太多，编译生成的中间目标文件太多，而在链接时需要明显地指出中间目标文件名，这对于编译很不方便，所以，我们要给中间目标文件打个包，在Windows下这种包叫“库文件”（Library File)，也就是 .lib 文件，在UNIX下，是Archive File，也就是 .a 文件
makefile规则：
    target...:prerequisites...
        command
        ...
        ...
    .PHONY : clean 
    clean : 
        -rm edit $(objects)
   一定要以一个Tab键作为开头 
makefile原理：
   prerequisites中如果有一个以上的文件比target文件要新的话，command所定义的命令就会被执行。这就是Makefile的规则。也就是Makefile中最核心的内容。
变量：
    objects = main.o kbd.o command.o display.o \ 
        insert.o search.o files.o utils.o
    引用：$(objects)
