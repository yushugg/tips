##Move data to /home/var, and create a soft-links
mkdir /home/var
Stop all the services
service mysqld stop
cp -pr /var/lib/mysql /home/var
rm -rf /var/lib/mysql
ln -s /home/var /var/lib/mysql
Start the services

owners:
chown -Rt mysql:mysql /home/var/mysql
###SELinux
chcon -Rt mysqld_db_t /home/var/mysql
