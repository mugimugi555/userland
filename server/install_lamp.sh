#!/bin/bash

echo "=========================================="
echo "🚀 Apache2 + MySQL + PHP 環境セットアップスクリプト（UserLAnd対応）"
echo "=========================================="

# ======================================================================
# システムのアップデート
# ======================================================================
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt upgrade -y

# ======================================================================
# 必要なパッケージをインストール
# ======================================================================
echo "📌 必要なパッケージをインストール..."
sudo apt install -y apache2 php php-mysql libapache2-mod-php php-cli php-xml php-mbstring mysql-server

# ======================================================================
# Apache2 のポート変更（80 → 8080）
# ======================================================================
echo "📌 Apache2 のポートを 8080 に変更..."
sudo sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf

# Apache2 を再起動
echo "📌 Apache2 を再起動..."
sudo service apache2 restart

# ======================================================================
# MySQL の初期設定
# ======================================================================
echo "📌 MySQL を起動..."
sudo service mysql start

# ======================================================================
# MySQL データベースの作成
# ======================================================================
echo "📌 MySQL データベースを作成..."
sudo mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE mydatabase DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON mydatabase.* TO 'myuser'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# ======================================================================
# phpinfo() の作成（動作確認用）
# ======================================================================
echo "📌 /var/www/html/index.php を作成..."
sudo bash -c 'echo "<?php phpinfo(); ?>" > /var/www/html/index.php'

# Apache2 と MySQL のステータス確認
echo "📌 Apache2 と MySQL のステータスを確認..."
sudo service apache2 status
sudo service mysql status

# ======================================================================
# 設定の確認 & 完了メッセージ
# ======================================================================
LOCAL_IPADDRESS=$(hostname -I | awk '{print $1}')
echo "=========================================="
echo "✅ Apache2 + MySQL + PHP のセットアップが完了しました！（UserLAnd対応）"
echo "💡 アクセス: http://$LOCAL_IPADDRESS:8080/index.php"
echo "=========================================="
echo "📌 データベース情報"
echo "DB Name  : mydatabase"
echo "DB User  : myuser"
echo "DB Pass  : mypassword"
echo "=========================================="
