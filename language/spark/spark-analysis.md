## Spark Overview

1. Driver: 用户自己写的程序，包含main()以及创建SparkContext

	* 如果在Master上运行，那么Driver就在Master上运行
	* 如果是YARN集群，那么Driver可能被调度到Worker节点上运行
	* 如果直接在自己的PC上运行，如eclipse上，则Driver就在自己的PC上
2. Worker内部：（一个application包含一个driver和多个executors）

	* 每个Worker上有一个或多个ExecutorBackend进程，每个进程包含一个Executor对象；
	* 每个对象持有一个线程池；
	* 每个线程执行一个task
3. 执行过程：
	
	* 初始化SparkConf()
	* 初始化SparkContext
	* 生成Job逻辑执行图
	* 生成DAG型的物理执行图：一个application可能包含多个job（按带有几个Action）；每个job包含多个stage；每个stage包含多个task(对应几个partition)
	* 执行调度...
	
4. 一个RDD中有多个partition，每个partition对应一个task，所以有几个core就可以设置几个partition

## Job Logical Plan

![logical-graph-process](logical-graph-process.tiff)

CreateRDD -> Transformation -> Action -> 将每个partition计算后的结果送回到driver端，进行f(list[result])，如sum  

### RDD Dependency

父RDD到子RDD可以是如下所示，**只有前后两个 RDD 的 partition 个数以及 partitioner 都一样,才可能会出现 NarrowDependency**：

* OneToOneDependency
* N:1 NarrowDependency
* N:N NarrowDependency
* ShuffleDependency
* RangeDependency(只在UnionRDD中)如下图：

![partition-dependency](partition-dependency.tiff)

- OneToOneDependency: map(f), filter(f), flatMap(f); mapPartitions(f), mapPartitionsWithIndex(f), pipe(command)
![onetoonedependency](onetoonedependency.tiff)
- RangeDependency: union(otherRDD)
![rangedependency](rangedependency.tiff)
- ShuffleDependency: 
	
	- groupByKey(numPartitions)
	- reduceByKey(func, numPartitions)
	- distinct(numPartitions)
	- cogroup(otherRDD, numPartitions), 和其他RDD一起group, 根据情况，有时会有OneToOneDependency(使用两个中的HashPartitioner)  
	对于两个或两个以上的 RDD 聚合,当且仅当聚合后的 RDD 中 partitioner 类别及 partition 个数与 前面的 RDD 都相同,才会与前面的 RDD 构成 1:1 的关系。否则,只能是 ShuffleDependency。
	- intersection(otherRDD): map将RDD[T]变成RDD[(T, null)] -> 进行a.cogroup(b) -> filter()过滤掉[iter(groupA()), iter(groupB()))]中groupA或者groupB为空的records，得到FilteredRDD -> 使用keys()只保留key
	- join(otherRDD, numPartitions): cogroup()得到<K, (Iterable[V1], Iterable[V2])> -> 对Iterable[V1]和Iterable[V2]做笛卡尔集
	- sortByKey(ascending, numPartitions)
	- ＊cartesian(otherRDD): 生成的 CartesianRDD 中 partition 个数 = partitionNum(RDD a) * partitionNum(RDD b)，CartesianRDD 中每个partition 依赖两个 parent RDD,而且其中每个 partition 完全依 赖 RDD a 中一个 partition,同时又完全依赖 RDD b 中另一个 partition。所有依赖都是 NarrowDependency。
	- coalesce(numPartitions, shuffle=false): 对parent RDD的partition的个数进行调整，增大或者减少(shuffle＝false的时候不能减少), coalesce(shuffle = true) 时,由于可以进行 shuffle,问题变为如何将 RDD 中所有 records 平均划分到 N 个 partition 中。在每个 partition 中,给每个 record 附加一个 key,key 递增,这样经过 hash(key) 后,key 可 以被平均分配到不同的 partition 中,类似 Round-robin 算法。
	- repartition(numPartitions): 相当于coalesce(numPartitions, shuffle=true)

### Primitive transformation()

combineByKey()

ShuffleDependency 左边的 RDD 中的 record 要求是 <key, value> 型的,经过 ShuffleDependency 后,包含相同 key 的 records 会被 aggregate 到一起,然后在 aggregated 的 records 上执行不同的 计算逻辑。

## Job Physical Plan

### 划分stage的算法

- 从后往前推算,遇到 ShuffleDependency 就断开,遇到 NarrowDependency 就将其加入该 stage; NarrowDependency可以进行pipeline
- 每个 stage 里面 task 的数目由该 stage 最后一个 RDD 中的 partition 个数决定。
- 每个RDD中的compute()调用parentRDD.iter()来将parent RDDs中的records一个个fetch过来
- 只有parent stage执行完了，children stage才能执行
![pipeline-task](pipeline-task.tiff)

### 生成job

用户的driver程序中一旦出现action()，就会生成一个job

## Shuffle

- Hadoop MapReduce是sort-based，进入combine()和reduce()的records必须先sort
- Spark是hash-based，通常使用HashMap来对shuffle的数据进行aggregate，要排序需要自己调用sortBykey()
- Spark, map端划分数据、持久化数据称为shuffle write（**shuffle会自动持久化数据**）；reducer端读入数据、aggregate数据称为shuffle read

### Shuffle write

每个 task 的 执行结果(该 stage 的 finalRDD 中某个 partition 包含的 records)被逐一写到本地磁盘上。每个 task 包含 R 个缓冲区, R = reducer 个数(也就是下一个 stage 中 task 的个数),缓冲区被称为 bucket

### Shuffle read

从MapPartitionsRDD中fetch数据，然后计算得到ShuffleRDD中的数据

- 当parent stage的所有ShuffleMapTasks结束后再fetch，为了符合stage的概念
- 边fetch边处理，使用HashMap，每次shuffle得到（从缓冲的FileSegment中deserialize出来）一个<Key, Value> record，直接放进HashMap里面，如果HashMap里面已经有此Key了，就直接进行aggregate操作，即func(hashMap.get(key), Value)；而Hadoop的是要sort的，数据结构无要求
- 刚fetch来的FileSegment存放在softBuffer缓冲区，经过处理后的数据放在内存＋磁盘上
![shuffle](shuffle.tiff)

注：

- sortByKey() 中 ShuffledRDD => MapPartitionsRDD 的处理逻辑与 reduceByKey() 不太一样,没有使用 HashMap 和 func 来处理 fetch 过来的 records。而是将 shuffle 过来的一个个 record 存放到一个 Array 里,然后按照 Key 来对 Array 中的 records 进行 sort。
- coalesce() 虽然有 ShuffleDependency,但不需要对 shuffle 过来的 records 进行 aggregate,所以没有建立 HashMap。 每 shuffle 一个 record,就直接流向 CoalescedRDD,进而流向 MappedRDD 中。
