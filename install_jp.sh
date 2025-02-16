#!/bin/bash

# ======================================================================================================================
# Locale & Timezone 設定
# ======================================================================================================================

# タイムゾーンを日本に設定
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
echo "Asia/Tokyo" | sudo tee /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

# 日本語フォントのインストール
sudo apt update
sudo apt install -y fonts-takao-pgothic fonts-takao-gothic fonts-takao-mincho

# ロケールのインストールと設定
sudo apt install -y locales
sudo locale-gen --purge "ja_JP.UTF-8"
sudo update-locale LANG=ja_JP.UTF-8

# 設定を適用
export LANG=ja_JP.UTF-8
echo "export LANG=ja_JP.UTF-8" >> ~/.profile

# ======================================================================================================================
# 設定完了メッセージ
# ======================================================================================================================
echo "==========================="
echo "日本語設定が完了しました"
echo "UserLAnd を再起動してください"
echo "==========================="
