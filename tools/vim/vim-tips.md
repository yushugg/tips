插件安装：
    一般直接覆盖到vimfiles中
    然后，在vimrc中修改一些配置重启即可使用

Excuberant ctags:
    windows下，将ctags.exe复制到vim73文件夹下，和vim.exe在同一文件夹下，然后要生成tags文件，在cmd下，运行ctags -R即可
    添加vimrc：
        set tags=tags;
        set autochdir
    第一个命令让vim在当前目录找tags文件，没找到，则递归父目录
    第二个命令让vim修改当前目录。分号必不可少

taglist:
    一般安装方法即可
    设置F3来开关Taglist窗口
    map <F3>:TlistToggle<cr>

pydiction:
    一个vim文件，一个complete-dict文件 
    vimrc配置：
        filetype plugin on
        let g:pydiction_location='F:\Vim\complete-dict'
        
