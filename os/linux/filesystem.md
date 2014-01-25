ext3:
    加入了日志
ext4:
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
