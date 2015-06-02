## HashingTF

将一个含有多个term的文档转换成一个词频Vector

1. 默认number of features是2^20
2. transform参数是doc，doc每一项是Iterable的term，使用mutable的HashMap，每次读取一个term，如果term已在HashMap中则原值加一，如果不在的话就记为0；最后Vectors.sparse(numFeatures, termFrequencies.toSeq)，得到结果Vector
3. transform若参数是dataset，每一项为一个doc，则转换为RDD[Vector]

## IDF

Inverse document frequency  
idf = log((m + 1) / (d(t) + 1))  
m: total number of documents  
d(t): number of documents that contain term t

TF-IDF(t, d) = tf * idf = f(t, d) * log((m + 1) / (d(t) + 1))  
**TF-IDF针对的是每个(term, doc) pair**

minDocFreq: 如果小于此数字，则idf ＝ 0

输入是HashingTF的词频向量，统计每个term在的doc数量，得到训练模型：fit(dataset: RDD[Vector]): IDFModel  
model.transform(dataset: RDD[Vector]): RDD[Vector]将TF向量转成TF-IDF向量tf*idf，每个term在当前该doc里的值