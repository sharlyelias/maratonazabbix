#sudo dnf update -y
#sudo dnf upgrade -y
sudo timedatectl set-timezone America/Sao_Paulo
sudo dnf install -y net-tools vim nano epel-release wget curl tcpdump expect
sudo setenforce 0
sudo dnf -y install mysql-server
sudo systemctl enable --now mysqld
MYSQL_SECURE=$(expect -c "

set timeout 10

spawn mysql_secure_installation

expect \"Press y|Y for Yes, any other key for No:\"
send \"y\r\"

expect \"Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:\"
send \"1\r\"

expect \"New password:\"
send \"Z@bb1xServer\r\"

expect \"Re-enter new password:\"
send \"Z@bb1xServer\r\"

expect \"Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect eof
")
echo "$MYSQL_SECURE"

MYSQL_SCRIPT=$(expect -c "

set timeout 10

spawn mysql -u root -p

expect \"Enter password:\"
send \"Z@bb1xServer\r\"

expect \"mysql>\"
send \"create database zabbix character set utf8 collate utf8_bin;\r\"

expect \"mysql>\"
send \"create user 'zabbix'@'localhost' identified by '2Maratona@Zabbix';\r\"

expect \"mysql>\"
send \"grant all privileges on zabbix.* to 'zabbix'@'localhost';\r\"

expect \"mysql>\"
send \"create user 'zabbix'@'192.168.0.150' identified with mysql_native_password by '2Maratona@Zabbix';\r\"

expect \"mysql>\"
send \"grant all privileges on zabbix.* to 'zabbix'@'192.168.0.150';\r\"

expect \"mysql>\"
send \"UPDATE mysql.user SET Super_Priv='Y' WHERE user='zabbix' AND host='192.168.0.150';\r\"

expect \"mysql>\"
send \"flush privileges;\r\"

expect \"mysql>\"
send \"quit\r\"

expect eof
")
echo "$MYSQL_SCRIPT"

sudo dnf remove expect -y
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=3306/tcp
sudo firewall-cmd --reload