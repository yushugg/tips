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
