## RDD

### RDD Creations

两种方式可以创建RDD：

1. 在driver程序中并行化一个collection
	
		val data = Array(1, 2, 3, 4, 5)
		val distData = sc.parallelize(data)
2. 使用外部存储的dataset，如local file system、HDFS、Cassandra、HBase
	
		val distFile = sc.textFile("data.txt")

default一个文件block是一个partition，可以设置partition数量，但是partition数量不能小于block数量

如果使用local filesystem，file必须能通过同样的path被所有worker nodes access，可以copy file到所有workers，或者使用network-mounted shared file system

SparkContext.wholeTextFiles可以read目录下的所有小文件，并且返回(filename, content)对

### RDD Operations

RDD支持两种类型的operations：

1. Transfromations: 从已有的RDD中创建一个新的RDD
2. Actions: 在dataset计算完成后返回一个值给driver program

所有的transformations都是lazy的，不立刻计算他们的值，只是记住dataset中应用了哪些transformations，只有当一个action需要返回结果给driver program的时候，transformations才会被计算  
默认情况下，transformed RDD会因为action而重复计算，但是可以使用persist(or cache)来在action执行之前保存在内存之中

### Shuffle Operations

Shuffle是在不同的partition里面re-distributing data，包括在不同的executors和machines之间copying data，由于需要的数据可能不在同一个partition上，甚至不在同一个machine上，所以需要跨越不同的partition来计算，一般一个task只在一个partition操作。

**shuffle会自动persist一些中间数据，不用显示调用persist**

会导致shuffle的操作：

1. repartition: repartition, coalesce
2. by key: groupByKey, reduceByKey
3. join: cogroup, join

## Shared Variables

### Broadcast Variables

一个缓存在每个机器的read-only变量

	val broadcastVar = sc.broadcast(Array(1, 2, 3))
	broadcastVar.value
	
### Accumulators

能够高效支持并行的"added"操作，常用来实现counters或者sums  
Accumulators因为lazy evaluation的存在，导致只有action执行了才会开始计算

	val accum = sc.accumulator(0, "My Accumulator")
	sc.parallelize(Array(1, 2, 3, 4)).foreach(x => accum += x)
	accum.value
	
	// 自定义非Int类型的accumulators
	object VectorAccumulatorParam extends AccumulatorParam[Vector] {
		def zero(initialValue: Vector): Vector = {
			Vector.zeros(initialValue.size)
		}
		def addInPlace(v1: Vector, v2: Vector): Vector = {
			v1 += v2
		}
	}

	// Then, create an Accumulator of this type:
	val vecAccum = sc.accumulator(new Vector(...))(VectorAccumulatorParam)