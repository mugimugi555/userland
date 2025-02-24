#!/bin/bash

echo "========================================="
echo "UserLAnd 用 OpenCV 最新版インストールスクリプト"
echo "========================================="

# ======================================================================================================================
# システムアップデート
# ======================================================================================================================
sudo apt update ;
sudo apt upgrade -y ;

# ======================================================================================================================
# 必要なライブラリのインストール
# ======================================================================================================================
sudo apt install -y                                              \
  build-essential cmake git pkg-config libgtk-3-dev              \
  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev       \
  libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
  gfortran openexr libatlas-base-dev python3-dev python3-numpy   \
  libtbb2 libtbb-dev libdc1394-22-dev ;

# ======================================================================================================================
# OpenCV ソースコードの取得
# ======================================================================================================================
cd ;
mkdir -p ~/opencv_build ;
cd ~/opencv_build ;

# 既存の OpenCV フォルダがあれば削除
rm -rf opencv opencv_contrib ;

# OpenCV リポジトリを取得
#git clone --depth=1 https://github.com/opencv/opencv.git ;
#git clone --depth=1 https://github.com/opencv/opencv_contrib.git ;
wget https://codeload.github.com/opencv/opencv/zip/refs/heads/4.x         -o opencv.zip
wget https://codeload.github.com/opencv/opencv_contrib/zip/refs/heads/4.x -o opencv_contrib.zip
unzip opencv.zip
unzip opencv_contrib.zip

# ======================================================================================================================
# OpenCV のビルド & インストール
# ======================================================================================================================
cd ~/opencv_build/opencv-4.x ;
mkdir -p build ;
cd build ;

# CMake の設定
cmake                                \
  -D CMAKE_BUILD_TYPE=RELEASE        \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D INSTALL_C_EXAMPLES=ON           \
  -D INSTALL_PYTHON_EXAMPLES=ON      \
  -D OPENCV_GENERATE_PKGCONFIG=ON    \
  -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib-4.x/modules \
  -D BUILD_EXAMPLES=ON .. ;

# コンパイル
make -j$(nproc) ;

# インストール
sudo make install ;

# ライブラリパスの設定
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/opencv.conf ;
sudo ldconfig ;

# OpenCV のバージョン確認
pkg-config --modversion opencv4 ;

# ======================================================================================================================
# Python 環境の設定
# ======================================================================================================================
PYTHON_VERSION=$(python3 -c "import sys; print(f'python{sys.version_info.major}.{sys.version_info.minor}')")
echo "export PYTHONPATH=\"/usr/local/lib/${PYTHON_VERSION}/site-packages:\$PYTHONPATH\"" >> ~/.bash_profile ;
source ~/.bash_profile ;

# ======================================================================================================================
# インストール完了 & 動作確認
# ======================================================================================================================
python3 -c "import cv2; print('✅ OpenCV version:', cv2.__version__)" ;

echo "========================================="
echo "🎉 OpenCV の最新版のインストールが完了しました！"
echo "========================================="
