## 处理数据归一化

### 处理方法

1. 线性函数转换: y = (x - minvalue) / (maxvalue - minvalue)
2. 对数函数转换: y = log10(x)
3. 反余切函数转换: y = atan(x) * 2 / PI
4. 综合1和2

### 作用

1. 某些不归一化的数据容易无法利用上，有些模型在各个维度不均匀伸缩后，最优解和原来不等价(SVM)，可能导致误差
2. 虽然有些模型各个维度不均匀伸缩后，最优解和原来等价(LR)，但如果使用迭代算法可以使收敛速度变快

## 数据不平衡问题

### 解决方法(数据层面、模型层面)

1. OverSampling或者UnderSampling或者两者结合
2. ensemble-based方法(集成学习)，比如bagging或者boosting，将负样本分成多份(多次下采样)，分别与正样本组合训练模型
3. SMOTE，对少数类样本进行分析并根据少数类样本人工合成新样本加入到数据集中，将邻近的样本作为新样本加入
4. cost function增加惩罚项，比如增加正样本的权重，减少负样本的权重
5. 使用不需要平衡数据的模型，如SVM
6. 使用Positive and Unlabeled data方法(one class learning，异常检测)，如果负样本中其实是未知正负性的

## 正则

1. L0正则可以获得稀疏解，但是难以优化求解：非0的元素的个数
2. L1正则可以获得稀疏解：参数中各个元素绝对值之和
3. L2正则可以防止过拟合：所有参数的平方和然后求平方根
4. L1会趋向于产生少量的参数，而其他的参数都是0(起到特征选择的作用)，而L2会选择更多的参数，这些参数都会接近于0
5. dropout：l1和l2是通过修改cost来实现的，dropout是修改神经网络本身来实现，随机删除一部分隐藏层的单元

## 评价方法

1. precision, recall, f1

        p = tp/(tp+fp)，预测中预测正确的
        r = tp/(tp+fn)，预测正确的除以其实所有都该正确的
        accuracy = (tp+tn)/(tp+fp+fn+tn)
        f1 = 2/(1/p+1/r)

2. roc, auc

        roc曲线：坐标x为fp rate，坐标y为tp rate
        auc为roc曲线下的面积

## loss

1. 0-1 loss
    
        L(Y, f(X)) = 1 if Y!=f(X) else 0

2. square loss

        L(Y, f(X)) = (Y - f(X))^2

3. absolute loss

        L(Y, f(X)) = |Y - f(X)|

4. log loss(LR)

        L(Y, f(X)) = -logP(Y|X)
        LR的loss: cost(h(x), y) = -log(h(x)) if y=1 else -log(1-h(x)) = -ylog(h(x)) - (1-y)log(1-h(x))

5. exp loss(Adaboost)

        L(Y, f(x)) = exp(-yf(x))

6. hinge loss(SVM)

        L(Y) = max(0, 1-yy'), y=+1or-1 (当|y|>=1, L(Y)=0)

## SVM和LR的异同

### 区别

1. Linear SVM和LR都是线性分类器，本质区别在loss不同，hinge loss和log loss(-logP(Y|X))
2. Linear SVM不直接依赖数据分布，分类平面不受**一类点影响，只考虑边界线附近的点**；**LR则受所有数据点的影响**，如果数据不同类别strongly unbalance一般需要先对数据做balancing(即正负样本比例要合适)
3. Linear SVM依赖数据表达的距离测度，所以需要对数据先做normalization；LR不受其影响
4. Linear SVM使用核函数处理非线性的问题很快，因为只考虑边界线上的数据；而LR由于需要考虑全部的数据，如果也用核函数复杂度会很高
5. Linear SVM依赖penalty的系数，实验中需要做validation
6. Linear SVM和LR的performance都会收到outlier的影响，其敏感程度而言，谁更好很难下明确结论

### 选择

1. 如果Feature的数量很大，跟样本数量差不多，这时候选用LR或者是Linear Kernel的SVM
2. 如果Feature的数量比较小，样本数量一般，不算大也不算小，选用SVM+Gaussian Kernel
3. 如果Feature的数量比较小，而样本数量很多，需要手工添加一些feature变成第一种情况

## Boosting和Bagging的异同

### Boosting

1. 从训练数据D中**不放回**的采样出d1，训练一个弱学习器C1
2. 从训练数据**不放回**的采样出d2，并加上前面50%的错误结果，训练出C2
3. 从训练数据采样出d3，并加上前面C1和C2错误的，训练出C3
4. 结合所有的学习器，投票得出结果

### Bagging

1. 生成n个不同的bootstrap训练样本
2. 为不同的样本训练出模型
3. 平均每个预测结果或者投票

### 区别

1. 最关键的区别是Bagging允许放回，Boosting不允许放回
2. Boosting将弱分类器组合成强分类器，权重不一样，Bagging权重平均
3. Bagging的基模型相关性较低，整体模型的Bias和基模型的Bias近似(准确率)，而通过增加基模型的数量可以减少Variance(过拟合)，因此Bagging的基模型为强模型(准确率高易过拟合的模型)，降低子模型间的相关度可以起到减少整体模型的方差的效果
4. Boosting的基模型相关性较高，若基模型不是弱模型(强模型易过拟合)，会导致整体模型Variance大(累积起来会过拟合)，因此Boosting的基模型为弱模型(准确率低但不容易过拟合)，通过增加基模型的数量来减少Bias(提升准确率)，但太多了容易过拟合
5. Bagging的训练过程旨在降低Variance，而Boosting的训练过程旨在降低Bias
6. Adaboost在迭代的时候改变样本的分布(提高错误预测样本的权重，减少正确预测样本的权重)，gradient boost不改变样本的分布在残差上学习

## 生成模型和判别模型

### 判别模型

1. 直接学习决策函数f(X)或者P(Y|X)
2. 如k邻近、感知机、决策树、SVM、EM等
3. 生成模型收敛速度比较快，需要样本数量多
4. 生成模型能够应付存在隐变量的情况

### 生成模型

1. 学习联合概率分布P(X,Y)，然后求出P(Y|X)，P(Y|X)=P(X,Y)/P(X)
2. 如朴素贝叶斯、HMM等
3. 与生成模型缺点对应，首先是节省计算资源，另外，需要的样本数量也少于生成模型
4. 准确率往往较生成模型高

## ReLU和sigmoid区别

1. sigmoid为指数运算，计算量大，ReLU计算量少，速度效率提高
2. 对于深层网络sigmoid反向传播容易出现梯度消失，导致信息丢失
3. ReLU会使部分神经元为0，使得网络稀疏，防止过拟合

## 聚类算法

### 相似性衡量

1. 距离：Lp norm(l1-绝对值/曼哈顿距离，l2-欧式距离，……)
2. 相似系数：夹角余弦，相关系数(不受原线性变换的影响，而且可以轻松地转换为距离，但其运算速度要比距离法慢得多，当维数很高的时候)
3. 核函数K(x, y)：把数据从低纬映射到高维空间
4. DTW(dynamic time warping)：可以计算两个不同长度的向量的距离，也可以对两对向量中不同时间段内的数据做匹配

### 聚类算法

1. Hierarchical methods：自下而上or自上而下，根据Linkage判断“类”的方法有最短距离法、最长距离法、中间距离法、类平均法等
2. Partition-based methods：类内的点都足够近，类间的点都足够远；多适用于中等体量的数据集，数据集越大，越有可能陷入局部最小

	- k-means++、intelligent k-means、genetic k-means：解决k-means对初始值的设置很敏感；
	- k-medoids和k-medians：解决k-means对噪声和离群值非常敏感；
	- k-modes：解决k-means只用于numerical类型数据，不适用于categorical类型数据；
	- kernel k-means：解决k-means不能解决非凸（non-convex）数据；
	- Spectral Clustering：先用Laplacian eigenmaps对数据进行降维(先将数据转换为邻接矩阵or相似性矩阵，再转换为Laplacian矩阵，再进行矩阵分解，把最小的K个特征向量排列在一起)，再使用k-means完成聚类，降维使得复杂度降低

3. Density-based methods：k-means解决不了不规则形状的聚类，对噪声数据的处理也比较好，两个参数，一个是圈儿的最大半径，一个是一个圈儿里最少应容纳几个点，如DBSCAN
4. Grid-based methods：原理就是将数据空间划分为网格单元，将数据对象集映射到网格单元中，并计算每个单元的密度，根据预设的阈值判断每个网格单元是否为高密度单元，由邻近的稠密单元组形成”类“，速度快，但对参数敏感，无法处理不规则数据，有维数灾难，如STING、CLIQUE
5. Model-based methods：基于概率模型或者神经网络，以概率形式表现“类”，但执行效率不高，如GMM、SOM

