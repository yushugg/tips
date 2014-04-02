尽量使用const，enum, inline而不是define
对于单纯常量，最好以const对象或者enums替换#define
对于形似函数的宏，最好使用inline函数替换#define

在class的头文件里，声明一个class，class的变量都是声明，没有定义
定义写在实现文件中（cpp文件）
***只有static const integral data members can be initialized，才可以被赋值，但是仍然不是定义，是声明，定义在实现文件中***

在类里面：
class GamePlayer {
private:
    static const int NumTurns = 5;
    int scores[NumTurns];
};
如果编译器不允许，需要在cpp文件中加入：
const in GamePlayer::NumTurns;
如果编译器不允许，可以将类声明里面不定义，而在cpp文件里加入定义

取一个const的地址是合法的，但是取一个enum的地址不合法，取define的地址也不合法

可以用enum代替static const int
class GamePlayer {
private:
    enum { NumTurns = 5 };
    int scores[NumTurns];
};

*左边的是所指物是const，*右边是指针本身const
const char* const p;
char const* const p;

对于迭代器：
迭代器类似T*，所以迭代器为const，表明指针是const，即T* const，指针不变，但是指针所指的东西可以改变
如果要所指向的东西不变，需用const_iterator

对函数返回值保持const，可以防止赋值操作的失误：
const Rational operator* (const Rational& lhs, const Rational& rhs);
可以防止 if (a*b = c)... 防止结果写反，立即被赋值

成员函数const：
1. 保证改不改变类的成员内容，不可以更改对象内任何non-static成员变量，但是如果成员内容添加了mutable，则这些可以被更改
2. 使得const对象可以调用函数，const对象只能调用const函数，如参数写的const Rational& xx，在该函数中，xx就可以调用const函数了
const对象可以读取成员变量，但是不能改变它们，所以读取是没问题的
为了不写两份代码（一份是const成员，一份不是），可以调用const_cast<char&>将const char&转换为char&，消除const；调用static_cast<const TextBlock&>(*this)[position]将非const的参数改为const类型的参数。<>里面的是转成的结果
利用const版本写出非const版本，先写const，再复用产生非const，反之不好，因为const成员函数绝不改动对象成员
