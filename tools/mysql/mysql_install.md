Step:

1. yum install mysql mysql-server mysql-devel(!!!)
2. start MySQL server and autostart MySQL on boot:  
    systemctl start mysqld.service ## use restart if updated
    systemctl enable mysqld.service
3. MySQL Secure Installation:  
    /usr/bin/mysql\_secure_installation
4. change root password:  
    mysqladmin -u root password [your\_password_here]
5. connect to MySQL:  
    mysql -u root -p  
    mysql -h localhost -u root -p
