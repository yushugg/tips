## for loop

### for loop with Ranges

	for (a <- 1 to 10) {
	// 1...10
		println("Value of a: " + a)
	}
	for (a <- 1 until 10) {
	// 1...9
		println("Value of a: " + a)
	}
	
### for loop with Collections

	for (var x <- List) {
		println("Value of x: " + x)
	}

### for loop with Filters

	for (a <- numList
			if a != 3; if a < 5) {
		println("Value of a: " + x)
	}
	
### for loop with yield
	
	var retVal = for {var a <- numList
						if a != 3; if a < 8
						} yield a
						
## Functions

### Call-by-Name

	def delayed(t: => Long) = {
		println("In delayed method")
		// 只有到这里才会开始计算t的值!!!
		println("Param: " + t)
	}
	
### Functions with Named Arguments

	def printInt(a: Int, b: Int) = {
		println("Value of a: " + a)
		println("Value of b: " + b)
	}
	// 调用
	printInt(b = 5, a = 7)
	
### Functions with Variable Arguments

	def printStrings(args: String*) = {
		for (arg <- args) {
			println("Arg: " + arg)
		}
	}
	// 调用
	printStrings("Hello", "Scala", "Cpp")
	
### Recursive Functions

	def factorial(n: BigInt): BigInt = {
		if (n <= 1)
			1
		else
			n * factorial(n - 1)
	}
	
### Default Parameter Values
	
	def addInt(a: Int=5, b: Int=7) : Int = {
		return a + b
	}
	// 调用
	addInt()
	
### Higher-Order Functions

	// 使用function作为参数
	def apply(f: Int => String, v: Int) = f(v)
	def layout[A](x: A) = "[" + x.toString() + "]"
	// 调用
	apply(layout, 10)
	
### Nested Functions

	def factorial(i: Int): Int = {
		def fact(i: Int, accumulator: Int): Int = {
			if (i <= 1)
				accumulator
			else
				fact(i - 1, i * accumulator)
		}
		fact(i, 1)
	}
	
### Anonymous Functions

	var inc = (x: Int) => x + 1
	var mul = (x: Int, y: Int) => x * y
	var userDir = () => { System.getProperty("user.dir") }
	
### Partially Applied Functions

	def log(date: Date, message: String) = {
		println(date + "----" + message)
	}
	// Define a new function
	val logWithDateBound = log(new Date, _: String)
	// Invoke
	logWithDateBound("message1")
	logWithDateBound("message2")
	
### Currying Functions

	// takes multiple parameters into a chain of functions
	def strcat(s1: String)(s2: String) = s1 + s2
	def strcat(s1: String) = (s2: String) => s1 + s2
	// Invoke
	strcat("foo")("bar")
	
## Closures

Closure is a function whose return value **depends on the value of one or more variables declared outside this function**.

	var factor = 3
	val multiplier = (i: Int) => i * factor
	// Above function references factor and reads its current value each time.

## Collections

### List

String, List is immutable，但是可以改变引用，指向新的String或者List  
要不可改变引用，使用val  

可以使用Nil和::来定义list

	val nums = 1 :: (2 :: (3 :: (4 :: Nil)))
	// nums: List[Int] = List(1, 2, 3, 4)
	
连接list
	
	var fruit = fruit1 ::: fruit2 // fruit1在前面
	var fruit = fruit1.:::(fruit2) // fruit2在前面
	var fruit = List.concat(fruit1, fruit2) // fruit1在前面
	
### Set

默认Set是immutable，可以导入scala.collection.mutable.Set来得到mutable的set

	// Concatenating Sets
	var fruit = fruit1 ++ fruit2
	var fruit = fruit1.++(fruit2)
	// intersection
	var num = num1.&(num2)
	var num = num1.intersect(num2)
	
### Map

默认Map是immutable，可以导入scala.collection.mutable.Map来得到mutable的Map
	
	var A: Map[Char, Int] = Map('L' -> 100, 'M' -> 55)
	A += ('I' -> 1)
	A += ('J' -> 5)
	A += ('K' -> 10)
	// Concatenating Sets
	var fruit = fruit1 ++ fruit2
	var fruit = fruit1.++(fruit2)
	
### Tuple

immutable，TupleN上限是22, 1<=N<=22

	val t = new Tuple3(1, "hello", Console)
	// syntactic sugar
	val t = (1, "hello", Console)
	// Access
	val sum = t._1 + t._2 + t._3 _ t._4
	
### Option

Option[T] is a container for zero or one element of a given type

## Pattern Matching

	def matchTest(x: Int) : String = x match {
		case 1 => "one"
		case 2 => "two"
		case _ => "many"
	}
	// case class
	case class Person(name: String, age: Int) // val is optional, if you want mutabl fields, use the var keyword