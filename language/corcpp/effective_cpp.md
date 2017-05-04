## 视C++为一个语言联邦

1. C: pass-by-value比pass-by-ref高效
2. Object-Oriented C++: pass-by-ref更好
3. Template C++: pass-by-ref更好
4. STL: 迭代器和函数塑造于C指针之上，pass-by-value更适用

## 尽量以const, enum, inline替换#define

### 原因：
    
1. 预处理不进入符号表，const可以进入符号表
2. #define预处理展开可能出现多份，const可以导致较小的代码量
3. #define没有作用域，且没有封装性

### class内的static const：

    class GamePlayer {
    private:
        static const int NumTurns = 5; // 常量声明式，不是定义式
    }

1. 如果是一个class专属常量，为static且为整数型(ints, chars, bools)，如果**不取此常量的地址**，就可以**声明并使用它们而无需提供定义式**
2. 如果取地址，或者编译器不支持，则需提供如下定义式:

        const int GamePlayer::NumTurns; // 可以不赋值，在声明的时候已经设置过处置

### enum hack

如果声明中有数组(编译器要求在编译器期间知道数组的大小)，如果编译器不允许static整型class常量的初始值设定，则可以enum hack
    
    class GamePlayer {
    private:
        enum { NumTurns = 5 };
        int scores[NumTurns];
    }

enum hack更像是#define，因为取enum地址不合法，取#define地址也不合法

## 尽可能使用const

### 常量与const

1. 如果const出现在星号左边，表示被指物是常量；出现在星号右边，表示指针自身是常量；出现在两边，表示被指物和指针都是常量
2. 迭代器和指针类似，声明一个迭代器为const，表示声明指针自身为const，要声明被指物，则用const\_iterator

### 函数与const

1. 若返回值为const，可以防止出现if (a * b = c)的情况
2. const成员函数，a. 控制哪个函数可以改动对象内容哪个不能，b. 操作const对象，修饰为const的对象，要有可以操控的const成员函数可用
3. const成员函数不可以更改对象内任何non-static成员变量，可用**mutable**释放掉non-static成员变量的const约束
4. 如果同时要实现const和non-const版本，可以**先实现const版本，然后用const\_cast做cast**，注意加上static\_const表示强制调用const版本，防止无限递归调用自己

        const_cast<char&>(static_cast<const TextBlock&>(*this)[position]);

## 确定对象被使用前已先被初始化

1. 对象成员变量的初始化发生在进入构造函数本体之前，在函数内部是**赋值，而不是初始化**，总是使用**成员初值列(member initialization list)**

        ABEntry::ABEntry(const std::string& name, const std::string& address, const std::list<PhoneNumber>& phones)
            : theName(name), theAddress(address), thePhone(phones), numTimesConsulted(0)
        { }

2. C++成员初始化顺序：base > derived，class成员变量总是以其**声明次序**被初始化，和成员初值列的顺序无关

### non-local static对象初始化次序

函数内的static对象为local static，其他static为non-local static对象；对于涉及两个源码文件，每个至少含有一个non-local static对象，某个non-local static对象的初始化使用了另一个编译单元的non-local static对象，C++对此初始化顺序无明确的定义；解决方法是**将每个non-local static对象搬到自己的专属函数内**，再返回一个ref指向所含的对象，通过函数调用这些non-local static对象，non-local static对象被local static对象替换了

    FileSystem& tfs() {
        static FileSystem fs;
        return fs;
    }
    Directory& tempDir() {
        static Directory td;
        return td;
    }
    std::size_t disks = tfs().numDisks();

这些函数"内含static对象"在多线程中有不确定性，解决方法是**在程序单线程启动阶段，手工调用所有ref-returning函数**

## 了解C++默默编写并调用哪些函数

如果没有声明，编译器会自动声明一个copy构造函数、一个copy assignment操作符、一个析构函数，如果也没有声明任何构造函数，编译器还会声明一个default构造函数，所有这些函数都是public且inline，**只有当这些函数被调用的时候才会被编译器创建出来**

    class Empty {
    public:
        Empty() { ... }
        Empty(const Empty& rhs) { ... }
        ~Empty() { ... }
        Empty& operator=(const Empty& rhs) { ... }
    }

如果已经声明了一个构造函数，编译器就不会生成一个default构造函数

### 构造函数的作用：

1. 构造器
2. 默认且隐含类型转换操作符，使用explicit可以避免不合时宜的类型转换，所有单参数的构造函数都必须使用

## 若不想使用编译器自动生成的函数，就该明确拒绝

1. 如果不想让copy构造函数或者copy assignment操作符被创建出来，可以声明为private
2. 不过member函数和friend函数还是可以调用private函数，可以**不定义只声明**，这样一旦被调用就会出现链接错误(如iostream中的ios\_base,basic\_ios,sentry)
3. 如果要将链接错误移到编译期间，可以构造一个base class，让copying为private，然后继承base

## 为多态基类声明virtual析构函数

1. 当class被用作多态base class，析构函数需要声明为virtual
2. 当class不企图当作base class(class里面不含任何virtual函数)，就不需要声明析构函数为virtual
3. 带有virtual函数的class维护一个vptr，会额外占用64bits(64位机器)
4. 像STL中的class不带virtual析构函数，如果继承会导致未定义的行为，故此类没有virtual析构函数的不要继承
5. **由于析构函数依次析构最深层到每个base class析构函数被调用，因此需要为base class的析构函数定义**

## 别让异常逃离析构函数

C++不禁止析构函数吐出异常，但是不鼓励如此，如果遇到DBConn这种需要close，又会跑出异常的：

1. 调用abort，强迫结束程序
        
        DBConn::~DBConn() {
            try { db.close(); }
            catch (...) {
                // record things
                std::abort();
            }
        }

2. 吞下异常，不推荐

        DBConn::~DBConn() {
            try { db.close(); }
            catch (...) {
                // record things
            }
        }

3. 将close权利交给用户(提供close接口)，并在析构函数中使用强迫停止的老路

## 绝不在构造和析构过程中调用virtual函数

在base class构造期间，virtual函数不是virtual函数，因为如果用到了多态，base class先于derived class被调用，此时对象类型是base class而不是derived class，**在编译期和运行期都会把对象视为base class类型**

## 令operator=返回一个reference to \*this

这样可以支持连续赋值

    Widget& operator=(const Widget& rhs) {
        ...
        return *this;
    }

    Widget& operator+=(const Widget& rhs) {
        ...
        return *this;
    }

## 在operator=中处理“自我赋值”

    Widget& Widget::operator=(const Widget& rhs) {
        if (this == &rhs) return *this;

        delete pb; // 不做自我赋值检测，就会出现把被赋值的对象也删除掉了
        pb = new Bitmap(*rhs.pb);
        return *this;
    }

上述代码如果new失败，会导致指针指向被删除的Bitmap，重新排列语句，可以改成如下，**在复制pb所指东西之前别删除pb**

    Widget& Widget::operator=(const Widget& rhs) {
        Bitmap* pOrig = pb;
        pb = new Bitmap(*rhs.pb);
        delete pOrig;
        return *this;
    }

或者使用copy and swap

    Widget& Widget::operator=(const Widget& rhs) {
        Widget temp(rhs);
        swap(temp);
        return *this;
    }

## 复制对象时勿忘其每一个成分

**当为derived class编写copying函数，必须复制其base class成分**，而这些成分往往是private的，无法直接访问，所以应该调用相应的base class的函数

    PriorityCustomer::PriorityCustomer(const PriorityCustomer& rhs)
        : Customer(rhs),
          priority(rhs.priority) {
        logCall("...");
    }
    
    PriorityCustomer& PriorityCustomer::operator=(const PriorityCustomer& rhs) {
        logCall("...");
        Customer::operator=(rhs);
        priority = rhs.priority;
        return *this;
    }

1. 复制所有local成员变量
2. 调用所有base classes内的适当的copying函数
3. **令copy assignment调用copy构造函数是不合理的**，这就像试图构造一个已经存在的对象

## 以对象管理资源

将资源放进对象内，当控制流离开函数，对象的析构函数会自动释放资源

    void f() {
        std::auto_ptr<Investment> pInv(createInvestment());
        ...
    }

1. 获得资源后立刻放进管理对象
2. 管理对象运用析构函数确保资源被释放
3. 由于auto\_ptr被销毁时会自动删除它所指之物，所以**不能让auto\_ptr同时指向同一对象，这样同一个对象会被删除多次**，auto\_ptrs有个性质：通过copy构造函数或者copy assignment操作符复制它们，它们会变成null，**复制所得的指针取得资源的唯一拥有权**

        std::auto_ptr<Investment> pInv1(createInvestment());
        std::auto_ptr<Investment> pInv2(pInv1); // pInv2指向对象，pInv1设为null
        pInv1 = pInv2; // pInv1指向对象，pInv2设为null

4. 引用计数型智慧指针(RCSP,会有循环引用的问题)，tr1::shared\_ptr就是个RCSP，上述代码中使用shared\_ptr的话，pInv1和pInv2都将指向对象
5. auto\_ptr和shared\_ptr**在析构函数内做的是delete不是delete[]**，所以不能用在数组上，替代品是vector，或者boost::scoped\_array,boost::shared\_array

## 在资源管理类中小心copying行为

对于资源管理类的copying行为，可以选择的处理方式为：

1. 禁止复制，如对Lock这样的类
2. 引用计数法，如shared\_ptr，可以自定义删除器(用在Lock上等)
3. 复制底部资源，深度拷贝
4. 转移底部资源的拥有权，如auto\_ptr

## 在资源管理类中提供对原始资源的访问

获取原始资源的访问：

1. 显式转换：使用get成员函数，返回原始指针(的复件)
2. 隐式转换：使用被重载后的指针取值操作符(operator->和operator\*)，可以用来直接取对象的数据和函数

## 成对使用new和delete时要采取相同形式

调用new时使用了[]，则必须调用delete[]；如果new没使用[]，则只需调用delete

## 以独立语句将newed对象置入智能指针

不应该直接在**函数的参数传递中newed对象放入智能指针，应该使用单独的语句**，因为函数的参数调用顺序是不确定的
