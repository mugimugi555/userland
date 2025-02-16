#!/bin/bash

echo "=========================================="
echo "🚀 最新版 WordPress インストールスクリプト"
echo "=========================================="

# ======================================================================
# システムの準備
# ======================================================================
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt install -y unzip curl wget software-properties-common

# ======================================================================
# 必要な Web サーバー & PHP のインストール
# ======================================================================
echo "📌 必要なパッケージをインストール..."
sudo apt install -y apache2 php php-mysql php-cli php-curl php-gd php-xml php-mbstring php-zip \
                    php-bcmath php-soap php-xmlrpc php-intl php-tokenizer mariadb-server

# ======================================================================
# MySQL (MariaDB) のセットアップ
# ======================================================================
echo "📌 MySQL を起動..."
sudo service mysql start

echo "📌 WordPress 用のデータベースを作成..."
sudo mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# ======================================================================
# WordPress のダウンロード & 設定
# ======================================================================
echo "📌 WordPress をダウンロード..."
cd /var/www/html
sudo wget https://ja.wordpress.org/latest-ja.zip
sudo unzip latest-ja.zip
sudo rm latest-ja.zip
sudo mv wordpress site
sudo chown -R www-data:www-data /var/www/html/site

# WordPress の設定ファイルを作成
echo "📌 wp-config.php を作成..."
cd /var/www/html/site
sudo cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/username_here/wordpress/" wp-config.php
sed -i "s/password_here/password/" wp-config.php

# Apache の設定（ポート 8080 に変更）
echo "📌 Apache を再起動..."
sed -i "s/Listen 80/Listen 8080/" /etc/apache2/ports.conf
sudo service apache2 restart

# ======================================================================
# 設定の確認 & 完了メッセージ
# ======================================================================
LOCAL_IPADDRESS=$(hostname -I | awk '{print $1}')
echo "=========================================="
echo "✅ WordPress のインストールが完了しました！"
echo "💡 アクセス: http://$LOCAL_IPADDRESS:8080/site"
echo "=========================================="
echo "📌 データベース情報"
echo "DB Name  : wordpress"
echo "DB User  : wordpress"
echo "DB Pass  : password"
echo "=========================================="
