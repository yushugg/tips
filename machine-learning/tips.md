## 处理数据归一化

### 处理方法

1. 线性函数转换: y = (x - minvalue) / (maxvalue - minvalue)
2. 对数函数转换: y = log10(x)
3. 反余切函数转换: y = atan(x) * 2 / PI
4. 综合1和2

### 作用

1. 某些不归一化的数据容易无法利用上，有些模型在各个维度不均匀伸缩后，最优解和原来不等价(SVM)，可能导致误差
2. 虽然有些模型各个维度不均匀伸缩后，最优解和原来等价(LR)，但如果使用迭代算法可以使收敛速度变快

## SVM和LR的异同

### 区别

1. Linear SVM和LR都是线性分类器，本质区别在loss不同
2. Linear SVM不直接依赖数据分布，分类平面不受**一类点影响，只考虑边界线附近的点**；**LR则受所有数据点的影响**，如果数据不同类别strongly unbalance一般需要先对数据做balancing
3. Linear SVM依赖数据表达的距离测度，所以需要对数据先做normalization；LR不受其影响
4. Linear SVM使用核函数处理非线性的问题很快，因为只考虑边界线上的数据；而LR由于需要考虑全部的数据，如果也用核函数复杂度会很高
5. Linear SVM依赖penalty的系数，实验中需要做validation
6. Linear SVM和LR的performance都会收到outlier的影响，其敏感程度而言，谁更好很难下明确结论

### 选择

1. 如果Feature的数量很大，跟样本数量差不多，这时候选用LR或者是Linear Kernel的SVM
2. 如果Feature的数量比较小，样本数量一般，不算大也不算小，选用SVM+Gaussian Kernel
3. 如果Feature的数量比较小，而样本数量很多，需要手工添加一些feature变成第一种情况
