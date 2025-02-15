#!/usr/bin/bash

# ======================================================================================================================
# one liner command
# ======================================================================================================================
# wget https://raw.githubusercontent.com/mugimugi555/userland/main/ubuntu/install_lamp.sh && bash install_lamp.sh ;

# ======================================================================================================================
# install common and add repository
# ======================================================================================================================
sudo apt install -y software-properties-common ;
sudo add-apt-repository -y ppa:ondrej/php ;

# ======================================================================================================================
# install php mysql apache
# ======================================================================================================================
sudo apt install -y apache2 mariadb-server php php-{mysql,gd,imap,ldap,xml,curl,mbstring,zip};
php -v ;
#sudo a2dismod php7.4 ;
#sudo a2enmod php8.1 ;
#sudo update-alternatives --config php ;

# ======================================================================================================================
# set port number
# ======================================================================================================================
# Apache の設定ファイル
PORTS_CONF="/etc/apache2/ports.conf"
VHOST_CONF="/etc/apache2/sites-available/000-default.conf"

echo "Apache のポートを 80 から 8080 に変更中..."

# ポート変更 (80 → 8080)
sudo sed -i 's/Listen 80/Listen 8080/g' "$PORTS_CONF"
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/g' "$VHOST_CONF"

# 変更後の設定を確認
echo "変更後の設定:"
grep "Listen" "$PORTS_CONF"
grep "<VirtualHost" "$VHOST_CONF"

# ======================================================================================================================
# start auto
# ======================================================================================================================
echo "export LD_LIBRARY_PATH=\"\"" | sudo tee -a /support/startVNCServerStep2.sh ;
echo "/usr/sbin/apachectl start"   | sudo tee -a /support/startVNCServerStep2.sh ;
echo "sudo service mysql start"    | sudo tee -a /support/startVNCServerStep2.sh ;

# ======================================================================================================================
# start manually
# ======================================================================================================================
sudo service mysql start ;
/usr/sbin/apachectl start ;

# ======================================================================================================================
# finish
# ======================================================================================================================
LOCAL_IPADDRESS=`hostname -I | awk -F" " '{print $1}'` ;
echo "======================================" ;
echo "visit => http://$LOCAL_IPADDRESS:8080/" ;
echo "======================================" ;
