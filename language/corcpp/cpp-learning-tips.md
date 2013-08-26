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
srand(time(0));// time() that returns the number of seconds since midnight on Jan 1, 1970
