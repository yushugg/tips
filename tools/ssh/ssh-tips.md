启动ssh：
    systemctl start sshd.service
    restart stop etc.
开机启动：
    systemctl enable sshd.service
将端口22加到防火墙的设置中，标记为Accept：
    iptables -A INPUT -p tcp --dport 22 -j ACCETP
    或者将上述参数加入防火墙配置中：
    vi /etc/sysconfig/iptables
    加入-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
