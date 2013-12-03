解决gvim错误：Gtk-WARNING **: Invalid input string
同时包括gvim的菜单栏显示异常一起解决
这个错误是由语言的设置不正确引起的，解决方法很简单：

1. 打开 cd /usr/share/vim/vim73/lang这个存放语言信息的目录。

2. 建立一个链接 sudo ln -s menu_zh_cn.utf-8.vim menu_zh_cn.utf8.vim，OK，问题解决。

插件安装：
    一般直接覆盖到vimfiles中
    然后，在vimrc中修改一些配置重启即可使用

Excuberant ctags:
    先下载安装ctags，然后设置环境变量，或者将ctags复制到vim73文件夹下，方便直接在终端运行ctags
    对于每个源码工程，若要生成tags文件，在cmd下，在根目录处，运行ctags -R即可
    添加vimrc：
        set tags=tags;
        set autochdir
    第一个命令让vim在当前目录找tags文件，没找到，则递归父目录
    第二个命令让vim修改当前目录。分号必不可少
    查找用<C-]>
    返回用<C-t>or<C-o>
    局部变量gd

Vundle:
    下载Vundle，放在$HOME/.vim/bundle/vundle
    设置好git
    配置vimrc
    以后安装插件，只要:BundleSearch，然后Bundle 插件名，再配置vimrc即可

taglist:
    一般安装方法即可
    设置F3来开关Taglist窗口
    map <F3>:TlistToggle<cr>

pydiction:
    一个vim文件，一个complete-dict文件 
    vimrc配置：
        filetype plugin on
        let g:pydiction_location='F:\Vim\complete-dict'
        
