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

ifconfig和route命令都已经废弃，使用ip命令来统一配置（也是暂时性的配置，要永久需要写入配置文件中）：
1. ip link：配置网络接口属性
    ip link show
    ip link set ethX {up|down|arp| {on|off}}
2. ip addr：配置网络地址
    ip addr show
    ip addr add IP dev ethX（此配置的网卡信息利用ifconfig看不到，要利用ip addr show来查看）
    ip addr del IP dev ethX
3. ip route：配置路由
    ip route show
    ip route change | replace
    ip route add to 目的网段 dev ethX via IP（下一跳IP）

其他网络命令：
ifconfig
route
ip
ping -c 3 -s 8000 -M do 10.10.98.98
traceroute -n ip
netstat -ntulpa
host www.baidu.com  查询host的IP

注意：-n选项是用来不将IP解析为主机名，速度更快
