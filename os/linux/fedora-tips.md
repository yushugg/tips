upgrade和update --obseletes的效果是相同的  
即会连一些即将淘汰的套件也一起升级，比较类似在做大规模的版本升级  
yum update是正确的系统更新方法，按需要更新  
yum upgrade是超级更新大法，只要是系统里的东西有更新的全部更新，  完全不管其实很多包已经不再需要了没用了该淘汰了，这样升级会导致很多，不用升级的包也升级，而这些包升级了也不再有用，不是垃圾是什么

fedora 源的修改：  
在目录/etc/yum.repos.d下，为所有的仓库，要换源可以下载仓库换掉对应的该目录下的仓库  
更新运行：sudo yum clean all 和 sudo yum makecache  
一般源的右边的help中会有教你安装源的方法