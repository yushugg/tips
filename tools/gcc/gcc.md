## 编译过程

预处理：
	
	gcc -E -o hello.i hello.c
	
编译(生成汇编中间代码)，包括词法分析、语法分析、语义分析、优化等：

	gcc -S -o hello.s hello.i
	
汇编(生成目标文件)：
	
	gcc -c -o hello.o hello.s
	
链接：

	gcc -o hello hello.o
	
静态链接库：-static  
动态链接库：-shared  
	
	gcc -shared -o libtest.so test.c
	gcc -L -ltest -o main main.c
	
注意设置LD\_LIBRARY\_PATH环境变量