# 视图跳转方法：

* 通过事件进行跳转
  1. presentModalViewController: control animated: YES
  2. dismissModalViewControllerAnimated: YES

* 通过NSNavigationBar进行跳转
  1. pushViewController: subTableViewController animated: YES
  2. popViewControllerAnimated: YES

# 关于Delegate

一个普通类如CBCentralManager，类里面一个变量是CBCentralManagerDelegate，此类负责CBCentral的基本操作
然后，有个protocol，即CBCentralManagerDelegate，负责相应操作事件发生时进行的补充操作，需要一个类去实现这个protocol，CBCentralManager就可以调用此实现好的delegate
CBCentralManager类的内部方法里面会调用对应的delegate，完成补充操作

有一个类必须继承CBCentralManagerDelegate，实现对应的protocol方法，然后只要管使用CBCentralManager就好了
