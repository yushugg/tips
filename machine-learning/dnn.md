## 梯度下降优化算法

学习率η决定达到最小值或者局部最小值过程中所采用的步长的大小

### 梯度下降法的变形形式

#### 批梯度下降(batch gradient descent)

在**整个训练数据集**上计算loss关于参数θ的梯度

    θ=θ−η⋅∇θJ(θ)

1. 速度慢
2. 需要将全部的数据集倒入内存中，对内存大小要求较高；每次更新一个参数会对相似的样本计算梯度，计算过程会有冗余
3. 无法在线更新模型，即运行时无法增加新的样本
4. 对于凸函数，可以收敛到全局最小；对于非凸函数，收敛到一个局部最小值

#### 随机梯度下降(stochastic gradient descent, SGD)

根据每一条训练样本x(i)和标签y(i)更新参数

    θ=θ−η⋅∇θJ(θ;x(i);y(i))

1. 速度快
2. 内存需求小；每次更新只执行一次，消除了计算冗余
3. 可以用于在线学习
4. SGD以高方差频繁地更新，导致目标函数出现剧烈波动；如果结果是局部最优：一方面，SGD可能跳到新的或潜在的更好的局部最优；另一方面，收敛过程会变得复杂，然而已经证明当缓慢减小学习率，SGD和批梯度下降具有相同的收敛行为，对于非凸和凸分别收敛到局部最小和全局最小

#### 小批量梯度下降(也成为SGD, Minibatch SGD)

每次更新使用n个小批量训练样本

    θ=θ−η⋅∇θJ(θ;x(i:i+n);y(i:i+n))

1. 减少参数更新的方差，得到更加稳定的收敛结果
2. 可以使用深度学习库中矩阵优化的方法，高效求解梯度

## 激活函数

### sigmoid

1. g(z) = 1 / (1 + e^-z)
2. 值域在0-1之间，当z非常大时，g(z)趋近于1；当z非常小时，g(z)趋近于0，适合于分类，可表示概率

## NN

隐藏层

    a1 = g(w10x0 + w11x1 + w12x2 + b1)
    a2 = g(w20x0 + w21x1 + w22x2 + b2)
    ...
    an = g(wn0x0 + wn1x1 + wn2x2 + bn)

## DNN

## CNN

1. conv + relu + pooling + fc

### conv

1. 权值共享：一个filter的w是确定的，用此一个filter去卷积图像的所有部分，同一个filter在图像不同位置上进行卷积时的w是不变的；因此卷积层的参数数量为filter size * filter number
2. depth: filter的个数，stride: 移动步长，zero-padding: 在外围边缘补充0
3. 参数：input, filter, strides, padding

    input: [batch, in_height, in_width, in_channels]
    filter: [filter_height, filter_width, in_channels, out_channels]
    strides: [1, 1, 1, 1]
    padding: padding的方法，"SAME"或者"VALID"
    output: 

### pooling

1. 作用：依靠局部不变性，下采样，降低维度，防止过拟合

## RNN

## LSTM

## GRU
