#!/bin/bash

echo "======================================"
echo "UserLAnd 用 OpenCV Headless インストールスクリプト"
echo "======================================"

# システム更新
echo "📌 システムをアップデート中..."
sudo apt update -y
sudo apt upgrade -y

# Python & C++ 版 OpenCV のインストール（Headless 版）
echo "📌 Python & C++ 版 OpenCV (Headless) をインストール中..."
sudo apt install -y python3-pip libopencv-dev

# 最新の OpenCV Headless を pip でインストール
echo "📌 最新の OpenCV Headless を pip でインストール..."
pip3 install --upgrade pip
pip3 install opencv-python-headless numpy

# 動画・画像処理ツールをインストール
echo "📌 FFmpeg & ImageMagick をインストール..."
sudo apt install -y ffmpeg imagemagick

# 動作確認（Python）
echo "📌 Python の OpenCV Headless バージョンを確認中..."
python3 -c "import cv2; print('✅ OpenCV Headless version:', cv2.__version__)"

# C++ 版 OpenCV の確認
echo "📌 C++ 版 OpenCV のバージョンを確認中..."
echo "#include <opencv2/opencv.hpp>" > test.cpp
echo "#include <iostream>" >> test.cpp
echo "int main() { std::cout << \"✅ OpenCV version: \" << CV_VERSION << std::endl; return 0; }" >> test.cpp

g++ -o test test.cpp `pkg-config --cflags --libs opencv4`
./test

# クリーンアップ
rm -f test.cpp test

echo "==========================="
echo "🎉 OpenCV Headless のインストールが完了しました！"
echo "==========================="
