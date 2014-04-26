" 不启用vi兼容模式
set nocompatible
filetype off

" ****************************************************************
"
" vim四个编码参数，enc(encoding), termencoding, fenc(fileencoding), fencs(fileencodings)
" enc(encoding)是vim内部使用的编码，与vim内部所有的buffer，寄存器，脚本中的字符串等相关，作用基本只是显示，不管最后文件是什么编码，vim都会将其转换为当前系统编码来处理，正常的显示出来
set encoding=utf-8
" termencoding 是vim用于屏幕显示的编码，vim会把内部编码转换为屏幕编码再用于输出，如果termencoding没有设置则直接使用encoding，不转码
" 对于gVim，不依赖于term，所以此项无意义
" fenc(fileencoding)当前文件的编码，可以将已经显示的文件保存为不同的编码，在于保存时的编码
set fenc=utf-8
" fencs(fileencodings)打开文件的时候进行解码猜测，有顺序
set fencs=utf-8,gb18030,gb2312,gbk,utf-16,big5,cp936
" 避免windows下菜单和系统提示出现乱码
" set encoding=utf-8
" set langmenu=zh_CN.UTF-8
" language message zh_CN.UTF-8
lang messages zh_CN.UTF-8
" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim
"
" ****************************************************************
"behave mswin

"set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"*****************************************************************
" basic settings
"set 行号 number
set nu
"set relativenumber
"set line & column
"set lines=30
"set columns=80
"文本编辑设置 
set sw=2 "自动缩进尺寸为2个空格 shiftwidth 当前行交错时使用2个空格
set ts=2 "Tab宽度为2个字符 tabstop
set et "编辑时将所有Tab替换为空格 

"断行设置 
set lbr "不在单词中间断行 
set fo+=mB "打开断行模块对亚洲语言支持 

"C/C++编码设置 
set sm "显示括号配对 showmatch
set cin "打开C/C++风格的自动缩进 cindent
set cino=:0g0t0(sus "设定C/C++风格自动缩进的选项 cinoptions
set ai "打开普通文件类型的自动缩进 autoindent

" 语法高亮
syntax enable
syntax on

"其他设置 
set selectmode= "不使用 selectmode 
set mousemodel=popup "当右键单击窗口的时候，弹出快捷菜单 
set keymodel= "不使用“Shift+方向键”选择文本 
set selection=inclusive "指定在选择文本时，光标所在位置也属于被选中的范围 

" 把jj当做Esc使用
inoremap jj <Esc>

" 把``当做补全使用
inoremap `` <C-P>

"设置leader
let mapleader = ","

"editing vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"无备份
set nobackup
"***********************************************************************
" Ctags settings
"设置常用工程的tags 第一个命令让vim在当前目录下查找tags文件，没找到则递归父目录
"第二个命令让vim修改当前目录。分号必不可少
"查找用<C-]>
"返回用<C-t>或者<C-o>
"局部变量gd
set tags=tags;
set autochdir
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"******************************************************************

"***************************************************************
" set Vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin() " start plugins
Plugin 'gmarik/Vundle.vim'

" plugin on github repos
" github上的用户写的插件，使用这种用户名+repo名称的方式
" Plugin 'https://github.com/scrooloose/nerdtree.git'
" Plugin 'tpope/vim-fugitive'

" vim-scripts repos
" vimscripts的repo使用下面的格式，直接是插件名称
Plugin 'taglist.vim'
Plugin 'molokai'
Plugin 'The-NERD-Commenter'
Plugin 'The-NERD-tree'
Plugin 'ctrlp.vim'
Plugin 'OmniCppComplete'
Plugin 'pythoncomplete'
Plugin 'MatchTag'
Plugin 'matchit.zip'

" non github reposo
" 非github的插件，可以直接使用其git地址
" Plugin 'git://git.wincent.com/command-t.git'

" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

call vundle#end() " end plugins
filetype plugin indent on

" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
" vundle主要就是上面这个四个命令，例如PluginInstall是全部重新安装，PluginInstall!则是更新
" 一般安装插件的流程为，先PluginSearch一个插件，然后在列表中选中，按i安装
" 安装完之后，在vimrc中，添加Plugin 'XXX'，使得bundle能够加载，这个插件，同时如果
" 需要配置这个插件，也是在vimrc中设置即可
" see :h vundle for more details or wiki for FAQ
"********************************************************************

"*************************************************
" Taglist
"设置F3来开关Taglist窗口 
map <F3> :TlistToggle<cr> 
let Tlist_Auto_Open=1 "启动vim后，自动打开taglist窗口
let Tlist_Show_One_File=1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow=1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Process_File_Always=1 "taglist始终解析文件中的tag，不管taglist窗口有木有打开
let Tlist_Use_Right_Window=1  "taglist显示在右边
" 空格，显示tag的原型定义
" u，更新taglist中的tag
" o，在新的窗口打开
" t，或者回车，跳到相应位置
" p, 预览位置，不会跳
" s，排序
" +，展开
" -，折叠
" *，全部展开
" =，全部折叠
" q，退出
"*************************************************

"*************************************************
" molokai
let g:molokai_original=1
"*************************************************

"*************************************************
" The-NERD-Commenter
" n,cc: 以下n行注释
" n,cu: 以下n行取消注释
" n,cm: 以下n行添加块注释
"*************************************************

"*************************************************
" OmniCppComplete
" <C-X><C-O>
set tags+=$HOME/.vim/tags/stl_tags
let OmniCpp_NamespaceSearch=1
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_ShowAccess=1
let OmniCpp_ShowPrototypeInAbbr=1 "显示函数参数列表
let OmniCpp_MayCompleteDot=1
let OmniCpp_MayCompleteArrow=1
let OmniCpp_MayCompleteScope=1
let OmniCpp_DefaultNamespaces=["std", "_GLIBCXX_STD"] "自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
"*************************************************

"*************************************************
" The-NERD-Tree
map <F2> :NERDTreeToggle<CR>  "F2快捷键
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif "关闭vim时，如果只有NERDTree，则关闭
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p "Auto focus on file
"*************************************************

"*************************************************
" pythoncomplete
"autocmd FileType python set omnifunc=pythoncomplete
"*************************************************

"*****************************************************
"设置折行、水平滚动条、配色方案 
if (has("gui_running")) 
" 图形界面下的设置 
    set guioptions+=b 
    colo molokai "colorscheme desert
    set wrap 
else 
" 字符界面下的设置 
    set wrap 
    "colo ron 
    set t_Co=256
    colo molokai
endif 

"============================================================================= 
" Platform dependent settings 
"============================================================================= 
if (has("win32")) 
    "------------------------------------------------------------------------- 
    " Win32 
    "------------------------------------------------------------------------- 
    if (has("gui_running")) 
        set guifont=Consolas:h12:cANSI 
        set guifontwide="Microsoft YaHei":h10:cGB2312 
    endif 
else 
    if (has("gui_running")) 
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
    endif 
endif 
"*******************************************************

"*************************************************
"编译运行函数
func Compile()
exec "w"
"C程序
if &filetype == 'c'
exec "!gcc -Wall % -g -o %<"
"c++程序
elseif &filetype == 'cpp'
exec "!g++ -Wall % -g -o %<"
endif
endfunc
"结束定义CompileRun
"定义Run函数
func Run()
if &filetype == 'c' || &filetype == 'cpp'
exec "!./%<"
endif
endfunc
"结束定义Run

"定义Debug函数，用来调试程序
func Debug()
exec "w"
"C程序
if &filetype == 'c'
exec "!gcc % -g -o %<"
exec "!gdb ./%<"
elseif &filetype == 'cpp'
exec "!g++ % -g -o %<"
exec "!gdb ./%<"
endif
endfunc
"结束定义Debug

"设置编译的快捷键
nnoremap <C-F5> :call Compile()
nnoremap <F5>   :call Run()
nnoremap <F9>   :call Debug()
"***********************************************

"python支持
"set filetype=python
"au BufNewFile,BufRead *.py,*.pyw setf python
