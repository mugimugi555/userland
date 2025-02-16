#!/bin/bash

echo "========================================="
echo "UserLAnd 用 OpenCV Headless 最新版インストールスクリプト"
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
  build-essential cmake git pkg-config                           \
  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev       \
  libjpeg-dev libpng-dev libtiff-dev openexr gfortran            \
  libtbb2 libtbb-dev libdc1394-22-dev python3-dev python3-numpy  \
  ffmpeg imagemagick ;

# ======================================================================================================================
# OpenCV ソースコードの取得
# ======================================================================================================================
cd ;
mkdir -p ~/opencv_build ;
cd ~/opencv_build ;

# 既存の OpenCV フォルダがあれば削除
rm -rf opencv opencv_contrib ;

# OpenCV リポジトリを取得
git clone --depth=1 https://github.com/opencv/opencv.git ;
git clone --depth=1 https://github.com/opencv/opencv_contrib.git ;

# ======================================================================================================================
# OpenCV のビルド & インストール（Headless 版）
# ======================================================================================================================
cd ~/opencv_build/opencv ;
mkdir -p build ;
cd build ;

# CMake の設定（GUI 関連を無効化）
cmake                                \
  -D CMAKE_BUILD_TYPE=RELEASE        \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D OPENCV_GENERATE_PKGCONFIG=ON    \
  -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
  -D BUILD_EXAMPLES=OFF              \
  -D BUILD_opencv_highgui=OFF        \
  -D BUILD_opencv_apps=OFF           \
  -D BUILD_opencv_java=OFF           \
  -D BUILD_opencv_python3=ON         \
  -D WITH_QT=OFF                     \
  -D WITH_GTK=OFF                    \
  -D WITH_OPENGL=OFF                 \
  -D WITH_V4L=ON                     \
  -D WITH_FFMPEG=ON .. ;

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
python3 -c "import cv2; print('✅ OpenCV Headless version:', cv2.__version__)"

echo "========================================="
echo "🎉 OpenCV Headless の最新版のインストールが完了しました！"
echo "========================================="
