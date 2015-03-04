1. 核心是numpy.array([list or tuple], type[int or float])，本质是list，如：[[1, 2, 3], [4, 5, 6]]
2. 加减乘除，求和、均值等运算针对的都是每一项具体的数据，不是做矩阵运算；如果要做矩阵运算，例如，求矩阵乘法，用numpy.dot(A, B)
3. numpy.random.rand产生随机的矩阵，数据是标准正态分布，可以在rand之前设置均值和方差，产生非标准的正态分布
