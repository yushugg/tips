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
