#!/bin/bash

echo "=========================================="
echo "🚀 最新版 Laravel インストールスクリプト"
echo "=========================================="

# ======================================================================
# システムの準備
# ======================================================================
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt install -y curl wget unzip

# ======================================================================
# 必要な PHP パッケージをインストール
# ======================================================================
echo "📌 PHP と Laravel に必要なモジュールをインストール..."
sudo apt install -y php php-cli php-xml php-bcmath php-mbstring php-zip php-curl php-tokenizer php-json \
                    php-common php-mysql php-intl php-soap php-xmlrpc php-gd php-sqlite3 php-redis mariadb-server

# ======================================================================
# Composer のインストール
# ======================================================================
echo "📌 Composer（PHP のパッケージマネージャー）をインストール..."
cd
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php
composer -v

# ======================================================================
# Laravel インストーラーのインストール
# ======================================================================
echo "📌 Laravel インストーラーをインストール..."
composer global require laravel/installer
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# ======================================================================
# Laravel プロジェクトの作成
# ======================================================================
echo "📌 最新の Laravel を取得..."
LATEST_LARAVEL_VERSION=$(composer show laravel/laravel --all | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)
echo "📌 最新の Laravel バージョン: $LATEST_LARAVEL_VERSION"

echo "📌 Laravel プロジェクトを作成中..."
laravel new testproject

# ======================================================================
# 権限の設定
# ======================================================================
echo "📌 権限を設定..."
sudo chown -R www-data:www-data testproject/storage testproject/bootstrap/cache

# ======================================================================
# Apache2 のセットアップ（必要な場合）
# ======================================================================
if [ -d "/etc/apache2" ]; then
    echo "📌 Apache2 の設定を更新..."
    sudo mv /var/www/html/ /var/www/html_back
    mkdir ~/html
    sudo ln -s /home/$USER/html/ /var/www/html
    echo "hi" > ~/html/index.html

    # Laravel 用のシンボリックリンク
    ln -s /home/$USER/testproject/public /var/www/html/testproject
fi

# ======================================================================
# MySQL セットアップ（必要に応じて）
# ======================================================================
#echo "📌 MySQL の初期設定を行う（root のパスワードを設定）..."
#sudo mysql_secure_installation

echo "=========================================="
echo "✅ Laravel のインストールが完了しました！"
echo "💡 アクセス: http://localhost/testproject"
echo "=========================================="
