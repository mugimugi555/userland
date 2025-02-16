#!/bin/bash

echo "=========================================="
echo "🚀 最新版 Ruby on Rails インストールスクリプト"
echo "=========================================="

# ======================================================================
# システムの準備
# ======================================================================
cd
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt install -y git curl wget

# ======================================================================
# rbenv & ruby-build のインストール
# ======================================================================
echo "📌 rbenv をインストール中..."
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
source ~/.bash_profile

echo "📌 ruby-build をインストール中..."
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

echo "📌 Ruby の依存パッケージをインストール..."
sudo apt install -y \
    autoconf bison build-essential libssl-dev \
    libyaml-dev libreadline6-dev zlib1g-dev   \
    libncurses5-dev libffi-dev libgdbm6 libgdbm-dev

# ======================================================================
# 最新の Ruby をインストール
# ======================================================================
echo "📌 利用可能な最新の Ruby バージョンを取得..."
LATEST_RUBY_VERSION=$(rbenv install -l | grep -v - | tail -n 1)
echo "📌 最新の Ruby バージョン: $LATEST_RUBY_VERSION"

echo "📌 Ruby をインストール中..."
rbenv install "$LATEST_RUBY_VERSION"
rbenv global "$LATEST_RUBY_VERSION"
ruby -v

# ======================================================================
# 最新の Node.js をインストール
# ======================================================================
echo "📌 最新版 Node.js をインストール..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
node -v

# ======================================================================
# Yarn & SQLite をインストール
# ======================================================================
echo "📌 Yarn & SQLite をインストール..."
sudo apt install -y yarn sqlite3 libsqlite3-dev

# ======================================================================
# 最新版の Rails をインストール
# ======================================================================
echo "📌 最新の Rails を取得..."
LATEST_RAILS_VERSION=$(gem search -ea rails | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)
echo "📌 最新の Rails バージョン: $LATEST_RAILS_VERSION"

echo "📌 Rails をインストール中..."
gem install rails -v "$LATEST_RAILS_VERSION"
rbenv rehash  # rbenv のリフレッシュ
rails -v

# ======================================================================
# Rails プロジェクトの作成
# ======================================================================
echo "📌 Rails プロジェクトを作成中..."
rails new blog
cd blog

# ======================================================================
# Rails サーバーを起動
# ======================================================================
LOCAL_IPADDRESS=$(hostname -I | awk '{print $1}')
echo "======================================="
echo "✅ Rails サーバーを起動します..."
echo "💡 アクセス: http://$LOCAL_IPADDRESS:8081/"
echo "======================================="

bin/rails server -b "$LOCAL_IPADDRESS" -p 8081
