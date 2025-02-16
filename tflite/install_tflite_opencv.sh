#!/bin/bash

echo "======================================"
echo "🚀 UserLAnd 用 TensorFlow Lite + OpenCV インストールスクリプト"
echo "======================================"

# ======================================================================
# システムアップデート
# ======================================================================
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt upgrade -y

# ======================================================================
# 必要な依存パッケージをインストール
# ======================================================================
echo "📌 必要なライブラリをインストール..."
sudo apt install -y python3-pip python3-numpy libatlas-base-dev \
                     build-essential cmake git pkg-config \
                     libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                     libjpeg-dev libpng-dev libtiff-dev openexr gfortran \
                     libtbb2 libtbb-dev libdc1394-22-dev ffmpeg imagemagick

# ======================================================================
# TensorFlow Lite のインストール
# ======================================================================
echo "📌 TensorFlow Lite をインストール..."
pip3 install --upgrade pip
pip3 install tflite-runtime tensorflow numpy

# ======================================================================
# OpenCV のインストール（CUI 版）
# ======================================================================
echo "📌 OpenCV Headless をインストール..."
pip3 install opencv-python-headless

# ======================================================================
# インストール確認
# ======================================================================
echo "📌 TensorFlow Lite のバージョン確認..."
python3 -c "import tflite_runtime.interpreter as tflite; print('✅ TensorFlow Lite version:', tflite.__version__)"

echo "📌 OpenCV のバージョン確認..."
python3 -c "import cv2; print('✅ OpenCV version:', cv2.__version__)"

echo "======================================"
echo "🎉 TFLite + OpenCV のインストールが完了しました！"
echo "======================================"
