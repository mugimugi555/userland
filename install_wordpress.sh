#!/usr/bin/bash

#
sudo apt install -y unzip ;

#
cd /var/www/html ;
wget https://ja.wordpress.org/latest-ja.zip ;
unzip latest-ja.zip ;

# sudo apt install apache2 php php-mysql-y  ;

#
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | sudo mysql ;
echo "GRANT ALL ON wordpress.* TO wordpress@localhost IDENTIFIED BY 'mypassword';" | sudo mysql ;
echo "FLUSH PRIVILEGES;" | sudo mysql ;

#
echo "http://localhost:8080/wordpress/" ;
echo "user_id  => wordpress " ;
echo "password => mypassword " ;
