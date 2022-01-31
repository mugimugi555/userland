#!/usr/bin/bash

# wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_lamp.sh && bash install_lamp.sh ;

sudo apt install -y apache2 php php-mysql mariadb-server ;

sudo sed -e 's/80/8080/' /etc/apache2/ports.conf ;

sudo echo "export LD_LIBRARY_PATH=\"\"" >> /support/startVNCServerStep2.sh ;
sudo echo "/usr/sbin/apachectl start" >> /support/startVNCServerStep2.sh ;
sudo echo "sudo service mysql start" >> /support/startVNCServerStep2.sh ;
