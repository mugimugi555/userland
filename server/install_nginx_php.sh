#!/bin/bash

echo "=========================================="
echo "🚀 Nginx + PHP-FPM セットアップスクリプト（UserLAnd対応）"
echo "=========================================="

# ======================================================================
# 設定: Nginx のポート番号
# ======================================================================
NGINX_PORT=9090

# ======================================================================
# システムの準備
# ======================================================================
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt upgrade -y

# ======================================================================
# 必要なパッケージをインストール
# ======================================================================
echo "📌 必要なパッケージをインストール..."
sudo apt install -y nginx php php-fpm php-cli php-mysql php-xml php-mbstring php-zip php-curl

# ======================================================================
# Nginx のポートを変更
# ======================================================================
echo "📌 Nginx の設定をポート $NGINX_PORT に変更..."
sudo sed -i "s/listen 80;/listen $NGINX_PORT;/" /etc/nginx/nginx.conf
sudo sed -i "s/listen \[::\]:80;/listen \[::\]:$NGINX_PORT;/" /etc/nginx/nginx.conf

# ======================================================================
# Nginx の PHP-FPM 設定を更新
# ======================================================================
echo "📌 Nginx の PHP-FPM 設定を更新..."
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOF
server {
    listen $NGINX_PORT;
    server_name localhost;

    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php\$ {
        include fastcgi_params;
        fastcgi_pass unix:/run/php/php-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

# ======================================================================
# PHP-FPM の起動（systemctl 不要）
# ======================================================================
echo "📌 PHP-FPM を起動..."
sudo service php-fpm start

# ======================================================================
# Nginx の再起動
# ======================================================================
echo "📌 Nginx を再起動..."
sudo service nginx restart

# ======================================================================
# PHP-FPM と Nginx のステータス確認
# ======================================================================
echo "📌 PHP-FPM と Nginx のステータスを確認..."
sudo service php-fpm status
sudo service nginx status

# ======================================================================
# PHP の動作確認ファイルを作成
# ======================================================================
echo "📌 /var/www/html/index.php を作成..."
sudo bash -c 'echo "<?php phpinfo(); ?>" > /var/www/html/index.php'

# ======================================================================
# 設定の確認 & 完了メッセージ
# ======================================================================
LOCAL_IPADDRESS=$(hostname -I | awk '{print $1}')
echo "=========================================="
echo "✅ Nginx + PHP-FPM のセットアップが完了しました！（UserLAnd対応）"
echo "💡 アクセス: http://$LOCAL_IPADDRESS:$NGINX_PORT/index.php"
echo "=========================================="
