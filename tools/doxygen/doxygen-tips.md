doxygen使用步骤：
    1. 给源码写正确格式的批注
    2. doxygen生成配置文件：doxygen -g config_name生成一个缺省的配置文件，再按需修改即可;
    3. doxygen生成文档：doxygen config_name生成文档

正确的批注格式：
JavaDoc类型：
    /**
     * ...text...
     *
     * @param a content
     * @param b content
     * @return a+b
     */
Qt类型：
    /*!
     * ...text...
     */

单行的批注类型：
/// ...text...
or
//! ...text...

doxygen视为解释后面的程序代码，如果解释前面的代码：
///< ...text...

常用指令：
!!!
注意如果要给一个file前面写注释，一定要加上@file！！！
!!!
@file 档案的批注说明
@author 作者信息
@brief 用于class或function的批注中，后面为class或function的简易说明
@param 格式为
    @param arg_name 参数说明
@return 返回值
@retval 传回值说明

常用配置：
INPUT = ./
RECURSIVE = YES
EXCLUDE = ./test 排除那些不想要处理的文件
OUTPUT选择不同格式输出
SOURCE_BROWSER = YES 可以包含代码
HAVE_DOT = YES 可以显示图形
JAVADOC_AUTOBRIEF = YES javadoc的第一行是为brief

配置分的部分：
Project相关
1. Project related configuration options
2. Build related configuration options
3. configuration options related to warning and progress messages

INPUT
4. configuration options related to the input files

源码显示
5. configuration options related to source browsing
6. configuration options related to the alphabetical class index

OUTPUT
7. configuration options related to the HTML output
8. configuration options related to the LaTeX output
9. configuration options related to the RTF output
10. configuration options related to the man page output
11. configuration options related to the XML output
12. configuration options for the AutoGen Definitions output
13. configuration options related to the Perl module output

预处理
14. Configuration options related to the preprocessor

外部引用
15. Configuration::additions related to external references

图形显示
16. Configuration options related to the dot tool

python说明：
doxygen1.4.4及以后版本，不支持python doc注释方式中的特殊指令，即不能使用@
但是使用##可以使用@
python是以namespace的形式来说明每个文件的
!!!
且最开始要加上@package xxx才会有用
!!!
