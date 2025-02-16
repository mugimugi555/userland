#!/bin/bash

echo "=========================================="
echo "🚀 最新版 PHP + 拡張モジュール インストールスクリプト"
echo "=========================================="

# ======================================================================
# システムの準備
# ======================================================================
VERSION_CODENAME=$(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME')

echo "📌 必要なパッケージをインストール中..."
sudo apt install -y gnupg2 ca-certificates apt-transport-https software-properties-common lsb-release

echo "📌 PHP リポジトリを追加..."
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
echo "deb https://packages.sury.org/php/ $VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/php.list

# ======================================================================
# PHP の最新バージョンを取得
# ======================================================================
echo "📌 利用可能な PHP バージョンを確認..."
sudo apt update
PHP_VERSION=$(apt-cache search ^php[0-9].[0-9]$ | awk '{print $1}' | sort -V | tail -n 1 | sed 's/php//')

if [ -z "$PHP_VERSION" ]; then
    echo "❌ エラー: PHP のバージョンを取得できませんでした。"
    exit 1
fi

echo "📌 最新の PHP バージョン: PHP $PHP_VERSION をインストールします。"

# ======================================================================
# PHP のインストール
# ======================================================================
echo "📌 PHP $PHP_VERSION をインストール中..."
sudo apt install -y \
    "php$PHP_VERSION"         "php$PHP_VERSION-cli"      "php$PHP_VERSION-fpm"   "php$PHP_VERSION-common"   \
    "php$PHP_VERSION-curl"    "php$PHP_VERSION-mbstring" "php$PHP_VERSION-xml"   "php$PHP_VERSION-zip"      \
    "php$PHP_VERSION-gd"      "php$PHP_VERSION-mysql"    "php$PHP_VERSION-pgsql" "php$PHP_VERSION-sqlite3"  \
    "php$PHP_VERSION-bcmath"  "php$PHP_VERSION-intl"     "php$PHP_VERSION-soap"  "php$PHP_VERSION-readline" \
    "php$PHP_VERSION-opcache" "php$PHP_VERSION-xmlrpc"   "php$PHP_VERSION-redis" "php$PHP_VERSION-imagick"  \
    "php$PHP_VERSION-dev"     "php$PHP_VERSION-ldap"

# ======================================================================
# PHP のバージョン確認
# ======================================================================
echo "📌 PHP のバージョン確認..."
php -v

echo "📌 インストール済み PHP 拡張モジュール一覧..."
php -m

echo "=========================================="
echo "🎉 PHP $PHP_VERSION のインストールが完了しました！"
echo "=========================================="
