#!/bin/bash

# 更新
echo "Updating package lists..."
sudo apt update -y
sudo apt upgrade -y

# 1. supervisordのインストール
echo "Installing supervisord..."
sudo apt install supervisor -y

# 2. Apache2のインストール
echo "Installing Apache2..."
sudo apt install apache2 -y

# 3. PHPのインストール
echo "Installing PHP and required modules..."
sudo apt install php php-mysql libapache2-mod-php php-cli php-xml php-mbstring -y

# 4. MySQLのインストール
echo "Installing MySQL server..."
sudo apt install mysql-server -y

# 5. MySQLの自動起動を無効化（supervisordが管理するため）
echo "Disabling MySQL systemd service..."
sudo systemctl disable mysql

# 6. Apache2のポート設定（ポートを8080に変更）
echo "Changing Apache2 port to 8080..."
sudo sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf

# 7. supervisordでApache2とMySQLを管理する設定ファイルの作成
echo "Creating supervisord configuration for Apache2 and MySQL..."

# Apache2の設定ファイル
sudo bash -c 'cat > /etc/supervisor/conf.d/apache2.conf << EOF
[program:apache2]
command=/usr/sbin/apache2ctl -D FOREGROUND
autostart=true
autorestart=true
stderr_logfile=/var/log/apache2.err.log
stdout_logfile=/var/log/apache2.log
EOF'

# MySQLの設定ファイル
sudo bash -c 'cat > /etc/supervisor/conf.d/mysql.conf << EOF
[program:mysql]
command=/usr/sbin/mysqld
autostart=true
autorestart=true
stderr_logfile=/var/log/mysql.err.log
stdout_logfile=/var/log/mysql.log
EOF'

# 8. supervisordの再読み込みと設定更新
echo "Reloading supervisor configuration..."
sudo supervisorctl reread
sudo supervisorctl update

# 9. Apache2とMySQLの起動（supervisordによって）
echo "Starting Apache2 and MySQL through supervisor..."
sudo supervisorctl start apache2
sudo supervisorctl start mysql

# 10. /var/www/html/index.php にphpinfo()を追加
echo "Creating index.php with phpinfo() for PHP verification..."
sudo bash -c 'echo "<?php phpinfo(); ?>" > /var/www/html/index.php'

# 11. Apache2とMySQLの状態確認
echo "Checking Apache2 and MySQL status..."
sudo supervisorctl status apache2
sudo supervisorctl status mysql

echo "Installation and configuration complete. Apache2, MySQL, and PHP are now managed by supervisord."
echo "You can check PHP info at http://localhost:8080/index.php"
