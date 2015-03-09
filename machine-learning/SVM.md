## SVM

### Basic and procedure

![SVM-Formula](svm-formula.tiff "SVM")

向量x被ø函数映射到更高的空间，SVM查找线性的最大间距超平面在这个空间里面。  
C>0是penalty parameter  
K(xi, xj) = ø(xi)tø(xj)是kernel function

Basic kernel function:

![Kernel-Function](kernel-function.tiff "Kernel-Function")

parameters: C, gama, r(coef), d

使用SVM基本步骤：

![Procedure](procedure.tiff "Procedure")

### RBF Kernel

RBF kernel非线性的将样本映射到一个更高维度的空间，可以处理非线性的样本；linear kernel是RBF的一个特例，sigmod kernel也是；polynomial kernel有比RBF更高维度参数，更为复杂。

### Cross-validation

对于RBF的两个参数C和gama，通过grid search来调试出参数，使用指数级的增长来设置参数(例如，C=2^-5, 2^-3, ..., 2^15, gama=2^-15, 2^-13, 2^3)，然后挨个测试；或者coarse grid，粗略的算出参数，然后再在该参数附近进行测试。

### Kernel的选择

如果特征的维度很大，就不需要将数据映射到高维度，即非线性的映射并不能提高性能，则使用linear kernel就足够好了，而且只需要搜索一个参数C。

#### Number of instances << number of features

不需要map到高维度，使用linear kernel就足以好

#### Both numbers of instances and features are large

这类通常是大规模的文档分类，LIBLINEAR更适合且高效  
LIBSVM并不是很合适，LIBLINEAR更合适，更快。

#### Number of instances >> number of features

features的维度低，通常map到高维度，使用非线性kernels

## PCA, LDA

PCA无监督的，找到一个坐标系，使得数据的投影在这两个维度上的方差差距最大，方差大的是signals，方差小的是噪音；  
LDA是有监督的，找到一个投影方向，使得两类数据的外部间距最大，内部方差最小