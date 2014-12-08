Standard Input and Output Objects:
==============

The library defines four IO objects: istream(cin), ostream(cout), two other ostream objects[cerr, clog]

    std::cout << "Hello" << std::endl;
    上述返回ostream对象，相当于将“hello”重定向到cout，并返回ostream对象，然后endl又重定向到此返回的ostream中，最后再返回ostream

    std::cin >> v1 >> v2;
    相当于将“cin重定向到v1，也返回istream对象，然后接着重定向到v2中，最后仍然返回istream对象

endl作用：ending the current line and FLUSHING THE BUFFER, 而不是留在内存中
