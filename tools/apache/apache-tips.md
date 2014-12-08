安装apache：

    yum install httpd

启动apache：

    service httpd start
    重启：service httpd restart
    关闭：service httpd stop

查看端口信息：

    netstat -tnl
    查看apache的80端口是否开启
    或者浏览器输入127.0.0.1检测
