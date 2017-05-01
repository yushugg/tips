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
