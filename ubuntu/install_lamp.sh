#!/usr/bin/bash

# wget https://raw.githubusercontent.com/mugimugi555/userland/main/ubuntu/install_lamp.sh && bash install_lamp.sh ;

#
sudo apt install -y software-properties-common ;
sudo add-apt-repository -y ppa:ondrej/php ;
sudo apt install -y apache2 libapache2-mod-php8.1 php8.1 mariadb-server ;
sudo apt install -y php8.1-{mysql,imap,ldap,xml,curl,mbstring,zip} ;
php -v ;
#sudo a2dismod php7.4 ;
#sudo a2enmod php8.1 ;
#sudo update-alternatives --config php ;
sudo sed -i '/Listen/{s/\([0-9]\+\)/8080/; :a;n; ba}' /etc/apache2/ports.conf

#
sudo echo "export LD_LIBRARY_PATH=\"\"" >> /support/startVNCServerStep2.sh ;
sudo echo "/usr/sbin/apachectl start"   >> /support/startVNCServerStep2.sh ;
sudo echo "sudo service mysql start"    >> /support/startVNCServerStep2.sh ;

#
sudo service mysql start ;
/usr/sbin/apachectl start ;

#
LOCAL_IPADDRESS=`hostname -I | awk -F" " '{print $1}'` ;
echo $LOCAL_IPADDRESS ;
echo "visit => http://$LOCAL_IPADDRESS:8080/" ;
