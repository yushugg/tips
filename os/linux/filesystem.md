## ext2, ext3, ext4

1. ext3:  
	加入了日志
2. ext4:  
    可允许的最大系统达到了1EB（1EB=1024PB，1PB=1024TB）  
    单个文件的大小也增加了  
    目录允许的子文件个数翻倍了（64,000比32,000）  
    增加了多块分配、延时分配、日志校验、快速fsck等，性能和可靠性提高了

create an ext2, ext3 or ext4 fs:  

    ext2:
        mke2fs /dev/sda1
    ext3:
        mkfs.ext3 /dev/sda1
        (or)
        mke2fs -j /dev/sda1
    ext4:
        mkfs.ext4 /dev/sda1
        (or)
        mke2fs -t ext4 /dev/sda1
        
## 软链接，硬链接

1. 硬链接作用是允许一个文件拥有多个有效路径名，inode相同，并没有创建新的文件，相当于别名，由于操作系统通过inode来查找实际上的文件，先通过文件名找到inode，然后通过inode来打开文件，所以硬链接实际上是多个文件别名，同一个inode，所以查找的时候，查找到的其实是同一个文件；并且通过计数来确定何时删除文件
2. 软链接其实是一个文件，有不同的inode
