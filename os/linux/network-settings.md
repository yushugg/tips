方法1：
  修改网卡IP等，具体文件：/etc/sysconfig/network-scripts/ifcfg-eht0
  其它方法改变的也是这个文件
  DNS文件：/etc/resolv.conf
  重启：service network restart

方法2：
  使用ifconfig命令，只能用来临时测试用，重启后会自动失效
  ifconfig eth0 xx.xx.xx.xx netmask yy.yy.yy.yy

方法3：
  netconfig图形界面配置
