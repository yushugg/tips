## List

1. ArrayList: 通过数组实现，当存储空间不够时复制现有数据到新的存储空间里；适合随机查找和遍历，不适合插入和删除
2. Vector: 通过数组实现，但支持多线程，花费高一点
3. LinkedList: 链表实现，适合动态插入和删除

三者均实现了List借口

ArrayList和Vector的区别：

1. ArrayList默认扩展内存是50%＋1，Vector是1倍
2. Vector提供indexOf(obj, start)接口，ArrayList没有
3. Vector属于线程安全级别，但开销更大

## Map

1. HashMap: 不保证迭代顺序；用hash表实现；允许key和value都是null
2. LinkedHashMap: 迭代顺序是插入顺序；用双向循环链表的hash表实现
3. TreeMap: 迭代按照compareTo的顺序，实现了SortedMap接口；不允许null keys，只允许null values；用红黑树实现
4. HashTable: 线程安全，基于synchronized实现的；不允许key或者value是null
5. ConcurrentHashMap: 线程安全，基于Lock实现的

![java maps](java-maps.tiff "java maps")

## Enumeration

1. Enumeration速度比Iterator快，而且占用的内存更少，没有Iterator安全，支持fail-fast(两个线程同时改变一个容器里面的数据的时候，会导致itertor不一致的结果)机制，因为其他线程不能够修改正在被Iterator遍历的集合里面的对象，以上都导致了Iterator会比较慢  
2. Enumeration只能读取数据，不能修改；Iterator可以有删除操作