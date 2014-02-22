doxygen使用步骤：
    1. 给源码写正确格式的批注
    2. doxygen生成配置文件：doxygen -g config_name生成一个缺省的配置文件，再按需修改即可;重要的三个参数--input，recursive，output
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
@file 档案的批注说明
@author 作者信息
@brief 用于class或function的批注中，后面为class或function的简易说明
@param 格式为
    @param arg_name 参数说明
@return 返回值
@retval 传回值说明
