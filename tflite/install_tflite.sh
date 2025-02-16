#!/bin/bash

echo "======================================"
echo "🚀 UserLAnd 用 TensorFlow Lite インストールスクリプト"
echo "======================================"

# システム更新
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt upgrade -y

# 必要な依存パッケージをインストール
echo "📌 必要なライブラリをインストール..."
sudo apt install -y python3-pip python3-numpy libatlas-base-dev

# TensorFlow Lite のインストール（Python）
echo "📌 TensorFlow Lite をインストール..."
pip3 install --upgrade pip
pip3 install tflite-runtime tensorflow numpy

# インストール確認
echo "📌 TensorFlow Lite のバージョン確認..."
python3 -c "import tflite_runtime.interpreter as tflite; print('✅ TensorFlow Lite version:', tflite.__version__)"

echo "======================================"
echo "🎉 TFLite のインストールが完了しました！"
echo "======================================"
