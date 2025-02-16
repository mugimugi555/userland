#!/bin/bash

echo "=========================================="
echo "🚀 最新版 Nginx インストールスクリプト"
echo "=========================================="

# ======================================================================
# 設定: 使用するポート番号
# ======================================================================
NGINX_PORT=9090

# ======================================================================
# システムの準備
# ======================================================================
VERSION_CODENAME=$(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME')

echo "📌 必要なパッケージをインストール中..."
sudo apt update -y
sudo apt install -y curl gnupg2 ca-certificates lsb-release debian-archive-keyring

# ======================================================================
# Nginx 公式リポジトリの追加
# ======================================================================
echo "📌 Nginx の公式 GPG キーを追加..."
wget -qO - http://nginx.org/keys/nginx_signing.key | sudo apt-key add -

echo "📌 Nginx の公式リポジトリを追加..."
echo "deb http://nginx.org/packages/debian/ $VERSION_CODENAME nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
echo "deb-src http://nginx.org/packages/debian/ $VERSION_CODENAME nginx" | sudo tee -a /etc/apt/sources.list.d/nginx.list
cat /etc/apt/sources.list.d/nginx.list

# ======================================================================
# 最新の Nginx をインストール
# ======================================================================
echo "📌 Nginx の最新版をインストール..."
sudo apt update
sudo apt install -y nginx

# ======================================================================
# Nginx のポートを指定の値に変更
# ======================================================================
echo "📌 Nginx の設定をポート $NGINX_PORT に変更..."
sudo sed -i "s/listen 80;/listen $NGINX_PORT;/" /etc/nginx/nginx.conf
sudo sed -i "s/listen \[::\]:80;/listen \[::\]:$NGINX_PORT;/" /etc/nginx/nginx.conf

# ======================================================================
# Nginx の再起動
# ======================================================================
echo "📌 Nginx を再起動..."
sudo service nginx restart

# ======================================================================
# Nginx のバージョン確認
# ======================================================================
echo "📌 インストールされた Nginx のバージョンを確認..."
nginx -v

echo "=========================================="
echo "🎉 最新の Nginx のインストール & ポート設定完了！"
echo "💡 アクセス: http://localhost:$NGINX_PORT/"
echo "=========================================="
