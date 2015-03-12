1. l-values and r-values:
    * In C++, variables are also known as l-values (pronounced ell-values). An l-value is a value that has an address (in memory). Since all variables have addresses, all variables are l-values. They were originally named l-values because they are the only values that can be on the left side of an assignment statement. When we do an assignment, the left hand side of the assignment operator must be an l-value. Consequently, a statement like 5 = 6; will cause a compile error, because 5 is not an l-value. The value of 5 has no memory, and thus nothing can be assigned to it. 5 means 5, and its value can not be reassigned. When an l-value has a value assigned to it, the current value is overwritten.
    * The opposite of l-values are r-values. An r-value refers to any value that can be assigned to an l-value. r-values are always evaluated to produce a single value. Examples of r-values are single numbers (such as 5, which evaluates to 5), variables (such as x, which evaluates to whatever number was last assigned to it), or expressions (such as 2+x, which evaluates to the last value of x plus 2).

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

4. You can undefine a previously defined value by using the #undef preprocessor directive. Consider the following snippet:

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
        	指针和array的区别：指针sizeof是一个指针大小，arraysizeof是所有连续空间的大小总和
        new
        delete

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

    C++新的casting的operator,告知编译器做的是强制的显示cast: 编译时static_cast,只会做标准的cast，而不做其它的

    运行时：dynamic_cast

    eg. float fValue = static_cast<float>(nValue1) / nValue2;

    四种cast操作：

        reinterpret_cast
        static_cast
        dynamic_cast
        const_cast

10. enum和switch语句，只能适用于整型的变量

    switch的case里必须是constant的

11. random numbers:

        #include <cstdlib> // for srand() and rand()
        // srand() sets the initial seed value. srand() should only be called once.

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

        const int nValue;
        const int *const pnPtr = &nValue; // 所有的都是const

        int nValue = 5;
        const int &rnRef = nValue; // 通过rnRef无法改变nValue

15. Rule: Always pass by const reference unless you need to change the value of the argument

    大多数情况使用pass by reference，而不用pass by pointer，除非要动态分配内存

    by reference只针对变量有用，对于常量无法使用

    return by reference只能针对reference，不能return函数内部的局部变量

    对于参数：如果literal，则不可&，可以考虑const，如果是大的对象什么的，则&,(eg.const Type &name)

    对于返回值：不要返回对于局部变量的引用，因为局部变量会destroy，除非返回值为输入的引用，否则不用返回引用,返回值如果const，则只能调用返回值的const成员函数

    对于函数：整个函数，只有是成员函数的时候才可以const，friend不是成员函数

        gen:    MyClass[&] func(const Class1 &m1, const Class2 &m2)

    如果返回值用到了&，则里面的参数m1和m2至少有一个是非const

16. Exceptions: Detecting assumption errors

    As it turns out, we can catch almost all assumptions that need to be checked in one of three locations:

    * When a function has been called, the user may have passed the function parameters that are semantically meaningless.
    * When a function returns, the return value may indicate that an error has occured.
    * When program receives input (either from the user, or a file), the input may not be in the correct format.

    Consequently, the following rules should be used when programming defensively:

    * At the top of each function, check to make sure any parameters have appropriate values.
    * After a function is called, check it’s return value (if any), and any other error reporting mechanisms, to see if an error occured.
    * Validate any user input to make sure it meets the expected formatting or range criteria.

    即三处检测：函数的参数传递、函数的返回值、用户的输入

17. Command line arguments

        int main(int argc, char* argv[]);
        int main(int argc, char** argv);
        argc: arg count     argv: arg variable

    都会把程序名算进去

18. class

    无static都是可以跨文件调用的

    * 默认为private,只可以被类里的函数调用,且不能被继承的类调用
    * public,可以被类外面的所有函数调用
    * protected，只可以被类里面的函数调用，也可以被继承的类调用

    The access specifiers only affect whether outsiders and derived classes can access those members.

    关于继承(所有的影响指的是，对于外面的通过派生类来访问时的改变，派生类内部的的访问基类时的属性不会改变)：

    每一个类里面的成员都可以访问成员，成员的access specifier针对的是**类外面对其的访问情况**

    继承以后，在子类里面access specifier改变了：

    * 默认为private继承，所有的成员变成private
    * public继承，所有的成员保持原来的acess specification
    * protected继承，private仍是private，但是public和protected变成protected

    例如，protected继承，在子类中，根据父类的access specifier，子类可以访问父类中的public和protected变量，但是如果新建了一个子类的实例，即子类的一个对象，则该对象无法访问任何成员了，因为变量要么是protected，要么是private

    继承的时候，share a base class，如此，PoweredDevice不会出现两次

        class Scanner : virtual public PoweredDevice{};
        class Printer : virtual public PoweredDevice{};
        class Copier : public Scanner, public Printer{};

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

    * const objects只能调用成员变量和const成员函数，调用非const成员函数会编译报错（在参数设为const Fraction& f，的时候，要考虑const对象调用的问题），反之，非const objects可以调用任意的变量和函数
    * const成员函数的两个作用：

        - 给const objects调用
        - 保证成员变量不被修改

    可以成员函数实现两个版本：const和非const的

    当传入的不是引用，而是值的时候，const就没有必要了，因为值传递本来就不会改变其原始的值

    所以const常用于引用传递

    总结函数中的参数传递，总共三种情况：

    * 对于一般类型，只需值传递，无需考虑其他
    * 对于对象，最好都传递引用&，分为const Fraction&（不能修改对象本身），和Fraction&（可以修改对象本身）
    * 对于指针类型，可以加const（不能修改指针所指的对象），和不加const（可以修改指针所指的对象），还有char* &xx;

    总结函数的返回值：

    * 如果返回的是其中一个参数，即参数为引用传递，才可以返回引用
    * 其他，如果参数都是const，则返回值

20. class static function

    * 无this指针，不属于哪个对象，属于类
    * 只能访问static member变量，非静态的不可访问

21. friend function and operator overloading

    friend function不属于成员函数

    在一个类中声明一个friend function，说明这个类对于此function开放，此func可以访问该类的private变量

    同样，声明一个friend class，代表此类向该friend class开放，friend class可以访问该类的private

    The best way to overload the operator is via friend function

    重载++和--：

    * Digit& operator++(); // prefix
    * Digit& operator--(); // prefix
    * Digit operator++(int); // postfix
    * Digit operator--(int); // postfix

    使用int来标注是后缀的,显然，prefix的效率更高

    The subscript operator[] is one of the operators that must be overloaded as a member function注意返回值必须是引用，否则无法接着用.来调用其成员函数，因为[]返回了非原对象

22. copy constructor

    当第一次赋值时，用的是copy constructor，当覆盖的时候用的是operator=

    There are three general cases where the copy constructor is called instead of the assignment operator:

    * When instantiating one object and initializing it with values from another object (as in the example above).
    * When passing an object by value.
    * When an object is returned from a function by value.

    值传递参数和return都是使用copy constructor

    引用传递和指针传递不会用到copy constructor, 是object本身

    C++会有默认的copy constructor和赋值=运算，但是是浅复制,即直接使用=号赋值各个变量的值，不会分配内存什么的

    所以最好自己写copy constructor，如果涉及到内存分配什么的，如char*的问题

    Summary:

    * The default copy constructor and default assignment operators do shallow copies, which is fine for classes that contain no dynamically allocated variables.
    * Classes with dynamically allocated variables need to have a copy constructor and assignment operator that do a deep copy.
    * The assignment operator is usually implemented using the same code as the copy constructor, but it checks for self-assignment, returns *this, and deallocates any previously allocated memory before deep copying.
    * If you don’t want a class to be copyable, use a private copy constructor and assignment operator prototype in the class header.

23. virtual function

    虚函数用在使得基类的指针或者引用可以直接调用访问继承类上

    A virtual function is a special type of function that resolves to the most-derived version of the function with the same signature. 

    You should always make your destructors virtual if you’re dealing with inheritance.

    当继承时，所有的析构函数都必须是virtual

    pure virtual function:

        virtual int getValue() = 0;

    任何有一个或者更多的纯虚函数的类是一个抽象基类(abstract base class),抽象基类不可以实例化

    Interface class:

    一个没有成员变量，有且只有纯虚函数的类

    多继承不可以有，但是多继承interface可以有

24. iostream

    cin会跳过whitespace(blanks, tabs, newlines)

        cin.get(ch)// 不会跳过whitespace，一个字符一个字符的读取
        cin.get(strBuf, 11)// 限制最大的size，含\0，实际长度为10，读取一个string，不跳过whitespace

    cin.get不会读取\n,即吸收\n,即读取了一次回车之后再次调用get时，由于前面的没有读取\n，\n成为了新的一次get的要读的内容，又是终止符，所以直接停止，且读的东西为空的，再次使用get时才会从屏幕中读取数据

    读取\n不代表会把\n作为最后一个字符,但是算读取的时候算长度+1

    cin.getline(strBuf, 11)用法同get，但是会读取\n

    cin.gcount()// 显示读取了多少字符

    读取std::string使用的是getline, 头文件为<string>

        string strBuf;
        getline(cin, strBuf);

    cout.setf()和cout.unsetf()提供修改cout的flags

    istringstream, ostringstream, stringstream类似isotream

    清除ostream里面的东西

        os.str(""); // erase the buffer
        os.clear(); // reset error flags

    对于scanf和cin读取一个字符c，如果前面先读取一个int或者string之类的东西，然后调用scanf或者cin读取字符c。

    scanf会直接跳过输入环节，而把上一个的\n作为输入，即吸收了\n

    而cin会一直等待你的输入，即不会吸收\n。

    但是cin.get和scanf是一样的。

    Summary:

    * cin.get读取char或者string时，都会吸收\n。
    * scanf, getchar读取char时，会吸收\n
    * 而cin本身不会吸收\n

    你会发现 %s 和 %d 是以’\n’当做输入的结束，而不吸收’\n’，所以当给b赋值时由于上次输入留下的’\n’没有被吸收，%c就要上它了。导致你没有输入b的值就直接出结果了。你可以把上面的首先给int赋初值改成给一个字符串赋初值，后面跟一个给char型字符覆初值。你会发现同样的问题。%c真是来者不拒，呵呵。

25. template

    模板遇到一个参数后，就根据此参数实例化一个函数，如果参数的两个类型不同，不会进行强制转换，所以就会报错；但是函数重载会进行强制转换

    函数识别过程：

    * 寻找一个参数完全匹配的函数
    * 寻找一个函数模板，若找到就将其实例化；不能强制转换参数匹配
    * 使用函数重载，通过类型转换产生参数匹配
    * 错误调用

    模板的实现必须也在.h的头文件中，不能放在cc文件中，否则在编译时，就无法确定具体的要分配的内存大小

26. 运算符重载

    当重载=，+=，-=，++，--等时，成员函数方法较好，因为要修改成员变量

    当重载二元运算什么的，使用friend更直观，而且可以解决friend operator+(int, Cents)的问题

    注意：当返回值是新建的时候，即产生的局部变量，返回类型不能使用引用返回；返回值引用只用在返回参数也是引用的且会改变该对象的属性值，参数也是引用；其他情况，参数就用const较好

    返回的是外部的已有的引用，则返回用&，且参数不要加const，其他情况参数加const较好，其他情况返回值不要返回引用

        // arithmetic operators(只用在const变量相加)
        friend Cents operator+(const Cents& c1, const Cents& c2){return Cents(c1.val+c2.val);}
        Cents operator+(const Cents& c){} // using member functions
        friend Cents operator-(const Cents& c1, const Cents& c2){}
        friend Cents operator*(const Cents& c1, const Cents& c2){}
        friend Cents operator/(const Cents& c1, const Cents& c2){}

        // io operators
        friend ostream& operator<< (ostream& out, Point& p){out << p.xx; return out;}
        friend istream& operator>> (istream& in, Point& p){in >> p.xx; return in;}

        // comparision operators
        friend bool operator== (Point& p1, Point& p2){}
        friend bool operator!= (Point& p1, Point& p2){}
        friend bool operator> (Point& p1, Point& p2){return p1.xx > p2.xx;}
        friend bool operator< (Point& p1, Point& p2){}
        friend bool operator>= (Point& p1, Point& p2){}
        friend bool operator<= (Point& p1, Point& p2){}

        // unary operators
        friend Cents operator-(const Cents& c){return Cents(-c.val);}
        Cents operator-(){} // using member functions
        friend bool operator!(const Cents& c){return c.val == 0;}

    要修改参数值时，传引用，并且传出引用

        // overloading the increment and decrement operators
        Digit& operator++()
        {
          ++val;
          return *this;
        }
        Digit& operator--()
        {
          --val;
          return *this;
        }
        // postfix
        Digit operator++(int)
        {
          Digit result(val);
          ++(*this);
          return result;
        }
        Digit operator--(int)
        {
          Digit result(val);
          --(*this);
          return result;
        }

    []和()返回引用是为了，可以给a[2], a(2, 3)这样的赋值

        // subscript operator
        int& operator[](const int nIndex){return val[nIndex]);}

        // parenthesis operator
        double& operator()(const int nCol, const int nRow){return data[nRow][nCol];}
        void operator()(){} // no parameters

        // typecasts
        operator int(){}
        operator Cents(){}

27. Copy constructor and overloading the assignment operator

        Cents(const Cents &c)
        {
          m_nCents = c.m_nCents;
        }
        Cents& operator=(const Cents& c)
        {
          // check for self-assignment
          if (this == &c)
            return *this;
          m_nCents = c.m_nCents;

          return *this;
        }

    传递参数尽量使用const&，当要改变其值时，用&即可，且返回值为&

28. 当传入的参数是指针的时候，如果在函数内部操作的时候进行new操作，则不会改变原指针，因为new操作是改变指针本身的值，即新的地址值

    因为指针传递传递的是指针的值罢了

    如果要new改变指针的值，则要传递指针的指针或者使用指针引用

        void func(node* n)
        {
          n = new node;
        }
        node* m = NULL;
        func(m);

    上述代码，是不会改变m的值的，传递的是指针的值，而内部改变的是指针的值，而不是指针所指的对象

    可以采用如下方式

        void func(node** n)
        {
          *n = new node;
        }

    or

        void func(node*& n)
        {
          n = new node;
        }

    如果指针所指向的东西是用来存储的，要用new动态分配，并且在存储东西使用完成之前，不可以将其delete；如果不用new或者delete掉了，则重新栈上分配的或者new分配的会是之前同样的地址，则存储的东西也就跟着改变了

    注意指针只是一个地址，所有参与的都只是地址，new出来的可能是之前删除的相同的地址

29. 访问成员数组名其实得到的是数组的**相对地址**，访问成员指针其实是相对地址的**内容**  
也就是对于数组char s[10]，s和&s是一样的  

		struct test {
			int i;
			short c;
			char* p;
			char s[10];
		};
		
		int main()
		{
			struct test* pt = NULL;
			printf("&s = %x\n", pt->s); // OK, 等价于&(pt->s)
			printf("&i = %x\n", &pt->i); // 取地址没有问题，但是如果访问pt->i，为访问内容，则不允许访问
		}
		
	同样，如果new int[0]，由于得到指针，取地址没问题，但是通过地址访问内容就是错误了。

30. C++中const表示常量，C表示只读，const只保证在编译器，运行期不保证；当对于常数的时候，通过指针，C++会保证不改，C++是直接常量替换，只保存在符号表不给常量分配内存，但C可以通过指针修改掉，C会给变量分配内存；但是如果是结构体，通过指针，C++也可以改变掉const的东西。