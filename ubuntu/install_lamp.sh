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
sudo apt install -y apache2 mariadb-server php php-cli libapache2-mod-php \
    php-mysql php-gd php-imap php-ldap php-xml php-curl php-mbstring php-zip
php -v ;

# ======================================================================================================================
# set port number
# ======================================================================================================================
# Apache の設定ファイル
PORTS_CONF="/etc/apache2/ports.conf"
VHOST_CONF="/etc/apache2/sites-available/000-default.conf"

echo "Apache のポートを 80 から 8080 に変更中..."

# ポート変更 (80 → 8080)
sed -i '/Listen/{s/\([0-9]\+\)/8080/; :a;n; ba}' "$PORTS_CONF"
sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/g' "$VHOST_CONF"
#sudo sh -c "sed -i '/Listen/{s/\([0-9]\+\)/8080/; :a; n; ba}' \"$PORTS_CONF\""
#sed '/Listen/{s/\([0-9]\+\)/8080/; :a; n; ba}' "$PORTS_CONF" | sudo tee "$PORTS_CONF" > /dev/null

# 変更後の設定を確認
echo "変更後の設定:"
grep "Listen" "$PORTS_CONF"
grep "<VirtualHost" "$VHOST_CONF"

# 設定の構文チェック
sudo apachectl configtest

# Apache を再起動
echo "Apache を再起動します..."
sudo service apache2 stop
sudo service apache2 start

# Apache の状態確認
sudo service apache2 status | grep "Active:"
curl -I http://localhost:8080

echo "ポート変更完了！Apache は 8080 で動作しています。"

# ======================================================================================================================
# start manually
# ======================================================================================================================
sudo service mysql start ;
sudo service apache2 start

# ======================================================================================================================
# add auto start
# ======================================================================================================================
echo "export LD_LIBRARY_PATH=\"\"" | sudo tee -a /support/startVNCServerStep2.sh ;
echo "/usr/sbin/apachectl start"   | sudo tee -a /support/startVNCServerStep2.sh ;
echo "sudo service mysql start"    | sudo tee -a /support/startVNCServerStep2.sh ;

# ======================================================================================================================
# finish
# ======================================================================================================================
LOCAL_IPADDRESS=`hostname -I | awk -F" " '{print $1}'` ;
echo "======================================" ;
echo "visit => http://$LOCAL_IPADDRESS:8080/" ;
echo "======================================" ;
