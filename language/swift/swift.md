1. 除了class之外，String、Array、Dictionary、Structure、enum等都是值传递，不是引用传递
2. Dictionary的lookup，返回的是一个optional value，因为可能存在key不存在的情况
3. 任意所有一部分值，用下划线_
4. value bindings，let或者var一个变量，case let (x, y) where x == y:
5. 命名参数func xxoo(xx x: Int, yy y: Int) -> String{} func xxoo(#x: Int, #y: Int) -> String func xxoo(x: Int = 0, y: Int = 0) -> String调用时一定要指定参数名称xxoo(xx: 1, yy: 2)，否则编译出错
6. 普通的func必须指定了external parameter names才可以使用命名参数形式，class里的method第二个参数开始默认有local和external parameter names且相同，init方法默认给所有的参数提供了local和external parameter names且相同，且必须使用，不使用将会报错，如果要不使用，external parameter使用_来代替，如init(_ celsius: Double) {}
7. func swapTwoInts(inout a: Int, inout b: Int) {}允许在内部改变a和b的值
8. 所有的基本类型：Int, Float, Double, Bool, String, Array, Dictionary都是值传递，内部实现都是通过Structure实现的，而Structure是值传递、Enumeration也是值传递、只有Class是引用传递；只有class是reference types
9. 检查是否两个reference指向相同的instance，用＝＝＝or!==
10. 由于structure是value types，如果一个structure instance是let的，尽管其property可能有var的，但是仍然不可更改其值，它的所有properties都是constant；但是class是reference types，如果class instance是let的，仍然可以更改var类型的property
11. stored properties（除了lazy stored properties）可以有willSet和didSet的property observers，inherited property（whether stored or computed）可以通过overriding有property observers；但一般的computed property，即含有get和set的，不能有willSet和didSet。两种不能同时存在
12. computed property用于检索或者设置其他的属性和值
13. 对于type property或type method，class用class关键字，struct和enum用static关键字
14. 改变structure和enumeration（value types）的property使用mutating关键字
15. ?显式定义一个Optional值，!隐式定义一个Optional值，区别在于取值的时候隐式的可以直接取值，不需要加上!，而显式的需要加上!，或者let d ＝ xx
