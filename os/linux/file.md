## 文件I/O读写API

fscanf, fprintf等格式化输入输出，文件的定位，都是将文件指针放在第一个参数位置上  
fread, fwrite等其他读写将文件指针放在最后一个参数位置上  

	#include <stdio.h>
	
	FILE* fopen(const char* filename, const char* mode);
	int flcose(FILE* stream);
	
	// format
	int fscanf(FILE* stream, const char* format, ...);
	int fprintf(FILE* stream, const char* format, ...);
	
	// Character
	int fgetc(FILE* stream);
	int fputc(int character, FILE* stream);
	char* fgets(char* str, int num, FILE* stream);
	int fputs(const char* str, FILE* stream);
	
	// Direct
	size_t fread(void* ptr, size_t size, size_t count, FILE* stream);
	size_t fwrite(const void* ptr, size_t size, size_t count, FILE* stream);
	
	// File positioning
	int fseek(FILE* stream, long int offset, int origin);
	long int ftell(FILE* stream); // Get current position in stream
	
系统调用的read, write将文件描述符放在第一个参数位置上，**只能读取字节**

	#include <unistd.h>
	
	int open(const char* path, int oflag, .../* mode_t mode*/); // 错误返回-1
	int close(int fd); // 成功返回0， 错误返回-1
	off_t lseek(int fd, off_t offset, int where); // 错误返回-1
	ssize_t read(int fd, void* buf, size_t nbytes); // 返回读取到的字节数，若已经到文件尾，返回0; 错误返回-1
	ssize_t write(int fd, const void* buf, size_t nbytes); // 返回已写的字节数; 错误返回-1