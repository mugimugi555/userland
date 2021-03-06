#!/bin/bash

# ======================================================================================================================
# one liner command
# ======================================================================================================================
# sudo apt update -y ; sudo apt install -y wget ; wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_wordpress.sh && bash install_wordpress.sh ;

# ======================================================================================================================
# utility install
# ======================================================================================================================
sudo apt install -y unzip ;
#sudo apt install -y apache2 php php-mysql mariadb-server ;
#sudo service mysql start ;
#/usr/sbin/apachectl start ;

# ======================================================================================================================
# install wordpress
# ======================================================================================================================
cd /var/www/html ;
wget https://ja.wordpress.org/latest-ja.zip ;
unzip latest-ja.zip ;

# ======================================================================================================================
# create database
# ======================================================================================================================
echo "SHOW DATABASES;"                                                               | sudo mysql -uroot ;
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | sudo mysql -uroot ;
echo "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';"                 | sudo mysql -uroot ;
echo "GRANT ALL ON wordpress.* TO 'wordpress'@'localhost';"                          | sudo mysql -uroot ;
echo "SHOW DATABASES;"                                                               | sudo mysql -uroot ;
echo "SELECT user, host FROM mysql.user;"                                            | sudo mysql -uroot ;

# ======================================================================================================================
# finish
# ======================================================================================================================
LOCAL_IPADDRESS=`hostname -I | awk -F" " '{print $1}'` ;
echo $LOCAL_IPADDRESS ;
echo "visit => http://$LOCAL_IPADDRESS:8080/wordpress/" ;
echo "ID       => wordpress" ;
echo "PASSWORD => password"  ;
echo "DB name  => wordpress" ;
