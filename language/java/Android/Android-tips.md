1. The Graphical User Interface for Android:

    ViewGroup包含View和ViewGroup，ViewGroup是一个容器，Layout，View是具体的组件，如buttons和text fields

    * 一个组件，包含id，layout
    * 一个Layout，包含layout，orientation

    layout_width和layout_height值：

    * match_parent: 充满整个父container
    * wrap_content: 刚好包裹住内容的大小
    
    layout_weight:

    * 用于每个View中，表示剩余空间每个View应该消耗的比例
    * 默认为0
    * 如果设为1，为了提高layout的效率，应该改变width为0dp，这样就不需要计算其他部分

    res:

    * @[+]res_folder/name
    * 如，@drawable/xxx，指向drawable里面的图片名，xxx.png
    * @string/intent_title，指向string文件夹里面的string，防止硬代码

    id:

    * [@][+]id/name，类型/名字，所以不同类型同名是可以的
    * @必需的，如果想从XML中引用该组件，想在代码中使用的话要设有id值
    * +意思是，如果res存在则使用它，如果res不存在，则新建一个

    如果想在代码中使用组件，要有个id，且通过R.layout.activity_main，R.id.btn_phone_call这样的方式，从R文件中获取

    R是连接代码和res xml配置的代码
