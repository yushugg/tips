## Linux进程状态

#### R(TASK_RUNNING)

可执行的状态，包括READY的和RUNNING的

#### S(TASK_INTERRUPTIBLE)

可中断的睡眠状态，等待某事件的发生

#### D(TASK_UNINTERRUPTIBLE)

不可中断的睡眠状态，进程不响应异步信号，用于某些内核处理流程的进程

#### T(TASK\_STOPPED or TASK_TRACED)

暂停or跟踪状态，gdb中调试是TASK_TRACED

#### Z(TASK\_DEAD-EXIT_ZOMBIE)

进程退出，处于TASK\_DEAD

1. **僵尸进程**：退出过程中，进程占有的所有资源将会被回收，只剩下task_struct，成为僵尸进程，等待父进程处理；如果父进程没有调用wait或waitpid获取子进程的状态信息，那么子进程的进程描述符仍然保存在系统中。  
处理僵尸进程一般是kill掉父进程，使其变成孤儿进程，然后由init来回收，或者kill掉tty，再不行重启
2. **孤儿进程**：父进程退出，而子进程还在运行，则子进程称为孤儿进程，将被init进程(pid=1)回收

#### X(TASK\_DEAD-EXIT_DEAD)

退出状态，进程即将被销毁

## fork, vfork, clone

内部实际上都是调用一个内核函数do_fork，只是参数不同  

1. vfork是fork的部分过程，用以简化提高效率。vfork创建的子进程与父进程**共享地址空间**，如果修改了子进程的某个变量，父进程也将会受到影响；vfork后的子进程还直接运行在父进程的栈空间，并使用父进程的**内存和数据**；用vfork创建的子进程必须**显示调用exit()**来结束，否则子进程不能结束；vfork子进程被创建后往往仅仅是为了调用exec来执行另一个程序，不比需要新的地址空间、内存等开销。
2. fork时进程资源的**完全复制**，复制父进程其它所有的资源，包括PCB、堆栈、用户空间、打开设备等；现在多数采用copy on write(COW写时复制)技术，fork最初并不会真的产生两个不同的拷贝，有了COW，vfork的意义就不大了
3. clone其实只有两项是被复制了的，后两项都与父进程共享，clone()带有参数，将父进程**资源有选择的复制**给子进程

子进程pid＝0，父进程pid>0  
子进程退出使用exit，父进程return  
父进程要使用wait或者waitpid来回收子进程的僵尸数据结构

		pid_t pid;
		pid = fork();
		if (pid < 0) {
			printf("Error\n");
		} else if (pid == 0) {
			// 子进程
			exit(0); // 结束子进程使用exit，而不是return
		} else {
			// 父进程
			sleep(60);
			wait(NULL); // 收集僵尸进程
		}