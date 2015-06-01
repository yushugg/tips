## 过拟合问题

### 解决过拟合

1. 减少特征数量
2. 正则化(改变[加大]参数sita的值，使得x的幂高的sita小，减小高幂x的影响)，**从sita1开始**  
	如果将lamda设置为一个极大的值，算法仍然会工作，但是会导致欠拟合，梯度下降算法不一定会收敛，除了sita0，其他的参数约等于0，即h(x) = sita0
	
## 逻辑回归

![logistic-regression](logistic-regression.tiff)