#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#define MAXLINE 4096

int main()
{
  int n;
  int fd[2];
  pid_t pid;
  char line[MAXLINE];

  if (pipe(fd) < 0)
    printf("pipe error");
  if ((pid = fork()) < 0)
    printf("fork error");
  else if (pid > 0)
  {
    // parent
    close(fd[0]); // close read-end
    write(fd[1], "hello world\n", 12); // open write-end
  }
  else
  {
    close(fd[1]); // close write-end
    n = read(fd[0], line, MAXLINE); // open read-end
    write(STDOUT_FILENO, line, n); // write to stdout
  }

  exit(0);
}

