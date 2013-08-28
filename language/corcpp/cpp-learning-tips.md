1. l-values and r-values:
In C++, variables are also known as l-values (pronounced ell-values). An l-value is a value that has an address (in memory). Since all variables have addresses, all variables are l-values. They were originally named l-values because they are the only values that can be on the left side of an assignment statement. When we do an assignment, the left hand side of the assignment operator must be an l-value. Consequently, a statement like 5 = 6; will cause a compile error, because 5 is not an l-value. The value of 5 has no memory, and thus nothing can be assigned to it. 5 means 5, and it’s value can not be reassigned. When an l-value has a value assigned to it, the current value is overwritten.
The opposite of l-values are r-values. An r-value refers to any value that can be assigned to an l-value. r-values are always evaluated to produce a single value. Examples of r-values are single numbers (such as 5, which evaluates to 5), variables (such as x, which evaluates to whatever number was last assigned to it), or expressions (such as 2+x, which evaluates to the last value of x plus 2).

2. Rule: Always assign values to your variables when you declare them.

3. If a long line that is broken into pieces is broken with an operator (eg. << or +), the operator should be placed at the end of the line, not the start of the next line:
cout << "This is a really, really, really, really, really, really, really, " <<
        "really long line" << endl;
Not
cout << "This is a really, really, really, really, really, really, really, "
        << "really long line" << endl;
This makes it more obvious from looking at the first line that the next line is going to be a continuation.
OPERAND first!!!
stream朝着尖的的方向流动

4. You can undefine a previously defined value by using the #undef preprocessor directive.
Consider the following snippet:
#define MY_NAME "Alex"
cout << "My name is " << MY_NAME << endl;
#undef MY_NAME
cout << "My name is " << MY_NAME << endl;
The last line of the program causes a compile error because MY_NAME has been undefined.

5. Preprocess
带有#的是预处理进行的，这些命令是C++不能识别的，不带有分号
如宏定义，define等都属于此

6. C++ operators
There are only three operators in C++ that is a word instead of a symbol:
sizeof: return data type's bytes
new
delete'

7. Float number precision
float和double，cout显示时都只有6 digits，不包括小数点，小数点前后总共6位
float 一般的精度为7个有效数字, double一般为16位有效数字
不过可以使用<iomanip>中的setprecision()来设置show,即cout的精度
cout << setprecision(16),不含小数点，小数点前后总共6位

8. 声明在外面的为global变量，其他的file也可以使用，但使用前要用extern声明一下
如果外面和里面都有同一个变量，则里面的为使用的，若要使用外面的，使用::nValue，前面加上::
file scope: 关键字为在global变量处加上static, 不可以使用extern，只可以在本文件中使用！！！
如果static加在block的里面，则使得变量拥有fixed duration

9. Casting
C的casting，float fValue = (float)nvalue1 / nValue2;
C++保留的C的casting, float fValue = float(nValue1) / nValue2; // 更像函数的调用
C++新的casting的operator,告知编译器做的是强制的显示cast: static_cast,只会做标准的cast，而不做其它的
eg. float fValue = static_cast<float>(nValue1) / nValue2;

10. enum和switch语句，只能适用于整型的变量
switch的case里必须是constant的

11. random numbers:
#include <cstdlib> // for srand() and rand()
srand() sets the initial seed value. srand() should only be called once.
设置初始值，只能使用一次,如，设置initial seed value为5323, srand(5323)
rand() generates the next random number in the sequence (starting from the seed set by srand()).
产生以后的每个number,调用rand()
范围为0到RAND_MAX，常为32767
产生nLow到nHigh的随机数：rand()%(nHigh-nLow+1) + nLow;
#include <ctime> // for time()
srand(time(0));// time() that returns the number of seconds since midnight on Jan 1, 1970; 0=NULL

12. array在声明时，int anArray[size]，size必须是constant：literal constant, define, const, enum
即必须在compile time就知道size的大小
在使用时，index可以是一个non-constant or constant的整数
int nSize = 5;
int anArray[nSize]; // Not OK! nSize is not a constant

13. strncpy(szDest, szSource, number)
    strncat
    strncmp
    ----------------------------
    char szBuffer[255];
    cin.getline(szBuffer, 255);
    std::string strName;
    getline(cin, strName);

14. delete删除的是指针指向的内存，指针还是存在
Get in the habit of assigning your pointers to 0 both when they are declared (unless assigned to another address), and after they are deleted. It will save you a lot of grief.
int *pnValue = new int;
delete pnValue;
pnValue = 0; // 指针还是存在，只是内存已被删除
int *const pnPtr = &nValue; // 指针pnPtr是const，只能指向nValue，不可改变,不能指向其他
const int *pnPtr = &nValue; // 指向的nValue不可改变, 即，通过pnPtr访问的nValue是const的
====================
const int nValue;
const int *const pnPtr = &nValue;
所有的都是const
====================
int nValue = 5;
const int &rnRef = nValue; // 通过rnRef无法改变nValue

15. Rule: Always pass by const reference unless you need to change the value of the argument
大多数情况使用pass by reference，而不用pass by pointer，除非要动态分配内存
by reference只针对变量有用，对于常量无法使用
return by reference只能针对reference，不能return函数内部的局部变量
=========================================================================================
对于参数：如果literal，则不可&，可以考虑const，如果是大的对象什么的，则&(gen:const Type &name)
对于返回值：不要返回对于局部变量的引用，因为局部变量会destroy，除非返回值为输入的引用，否则不用返回引用,返回值如果const，则只能调用返回值的const成员函数
对于函数：整个函数，只有是成员函数的时候才可以const，friend不是成员函数
gen:    MyClass[&] func(const Class1 &m1, const Class2 &m2)
    如果返回值用到了&，则里面的参数m1和m2至少有一个是非const
=========================================================================================

16. Exceptions: Detecting assumption errors
As it turns out, we can catch almost all assumptions that need to be checked in one of three locations:
1. When a function has been called, the user may have passed the function parameters that are semantically meaningless.
2. When a function returns, the return value may indicate that an error has occured.
3. When program receives input (either from the user, or a file), the input may not be in the correct format.
Consequently, the following rules should be used when programming defensively:
1. At the top of each function, check to make sure any parameters have appropriate values.
2. After a function is called, check it’s return value (if any), and any other error reporting mechanisms, to see if an error occured.
3. Validate any user input to make sure it meets the expected formatting or range criteria.
即三处检测：函数的参数传递、函数的返回值、用户的输入

17. Command line arguments
int main(int argc, char* argv[]);
int main(int argc, char** argv);
argc: arg count     argv: arg variable
都会把程序名算进去

18. class
无static都是可以跨文件调用的
默认为private,只可以被类里的函数调用,且不能被继承的类调用
public,可以被类外面的所有函数调用
protected，只可以被类里面的函数调用，也可以被继承的类调用
===========================================================
The access specifiers only affect whether outsiders and derived classes can access those members.
关于继承(所有的影响指的是，对于外面的通过派生类来访问时的改变，派生类内部的的访问基类时的属性不会改变)：
默认为private继承，所有的成员变成private
public继承，所有的成员保持原来的acess specification
protected继承，private仍是private，但是public和protected变成protected
===========================================================
Provide a default constructor is almost always a good idea.

19. class const function
const class objects can only call const member functions
const member function:
    int getValue() const
    {
        return m_nValue;
    }
Any const member function that attempts to change a member variable or call a non-const member function will cause a compiler error
const member function只能调用const member，而且不能改变成员变量

20. class static function
1) 无this指针，不属于哪个对象，属于类
2) 只能访问static member变量，非静态的不可访问

21. friend function and operator overloading
friend function不属于成员函数
在一个类中声明一个friend function，说明这个类对于此function开放，此func可以访问该类的private变量
同样，声明一个friend class，代表此类向该friendclass开放，friend class可以访问该类的private
The best way to overload the operator is via friend function
重载++和--：
Digit& operator++(); // prefix
Digit& operator--(); // prefix
Digit operator++(int); // postfix
Digit operator--(int); // postfix
使用int来标注是后缀的,显然，prefix的效率更高
The subscript operator[] is one of the operators that must be overloaded as a member function注意返回值必须是引用，否则无法接着用.来调用其成员函数，因为[]返回了非原对象

22. copy constructor
******当第一次赋值时，用的是copy constructor，当覆盖的时候用的是operator=*******
There are three general cases where the copy constructor is called instead of the assignment operator:
a. When instantiating one object and initializing it with values from another object (as in the example above).
b. When passing an object by value.
c. When an object is returned from a function by value.
!!!值传递参数和return都是使用copy constructor
!!!引用传递和指针传递不会用到copy constructor, 是object本身
C++会有默认的copy constructor和赋值=运算，但是是浅复制,即直接使用=号赋值各个变量的值，不会分配内存什么的
所以最好自己写copy constructor，如果涉及到内存分配什么的，如char×的问题
Summary:
**The default copy constructor and default assignment operators do shallow copies, which is fine for classes that contain no dynamically allocated variables.
**Classes with dynamically allocated variables need to have a copy constructor and assignment operator that do a deep copy.
**The assignment operator is usually implemented using the same code as the copy constructor, but it checks for self-assignment, returns *this, and deallocates any previously allocated memory before deep copying.
**If you don’t want a class to be copyable, use a private copy constructor and assignment operator prototype in the class header.

23. virtual function
虚函数用在使得基类的指针或者引用可以直接调用访问继承类上
A virtual function is a special type of function that resolves to the most-derived version of the function with the same signature. 
You should always make your destructors virtual if you’re dealing with inheritance.
当继承时，所有的析构函数都必须是virtual
pure virtual function:
virtual int getValue() = 0;
任何有一个或者更多的虚函数的类是一个抽象基类(abstract base class),抽象基类不可以实例化
Interface class:
一个没有成员变量，有且只有虚函数的类
多继承不可以有，但是多继承interface可以有

24. iostream
cin会跳过whitespace(blanks, tabs, newlines)
cin.get(ch)// 不会跳过whitespace，一个字符一个字符的读取
cin.get(strBuf, 11)// 限制最大的size，含\0，实际长度为10，读取一个string，不跳过whitespace
cin.get不会读取\n,即读取了一次回车之后再次调用get时，由于前面的没有读取\n，\n成为了新的一次get的要读的内容，又是终止符，所以直接停止，且读的东西为空的，再次使用get时才会从屏幕中读取数据
***********************************************************
读取\n不代表会把\n作为最后一个字符,但是算读取的时候算长度+1
***********************************************************
cin.getline(strBuf, 11)用法同get，但是会读取\n
cin.gcount()// 显示读取了多少字符
===========================================================
读取std::string使用的是getline, 头文件为<string>
string strBuf;
getline(cin, strBuf);
