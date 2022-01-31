#!/usr/bin/bash

sudo apt install -y unzip ;

cd /var/www/html ;
wget https://ja.wordpress.org/latest-ja.zip ;
unzip latest-ja.zip ;

echo "SHOW DATABASES;" | sudo mysql -uroot ;
echo "SHOW DATABASES;" | sudo mysql -uroot ;
echo "SHOW DATABASES;" | sudo mysql -uroot ;

echo "CREATE DATABASE wordpress ;"                                   | sudo mysql -uroot ;
echo "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';" | sudo mysql -uroot ;
echo "GRANT ALL ON wordpress.* to 'wordpress'@'localhost';"          | sudo mysql -uroot ;

echo "SHOW DATABASES;"                    | sudo mysql -uroot ;
echo "SELECT user, host FROM mysql.user;" | sudo mysql -uroot ;

LOCAL_IPADDRESS=`hostname -I | awk -F" " '{print $1}'` ;
echo $LOCAL_IPADDRESS ;

echo "visit => http://$LOCAL_IPADDRESS:8080/wordpress/" ;
echo "ID       => wordpress" ;
echo "PASSWORD => password"  ;
echo "DB name  => wordpress" ;
