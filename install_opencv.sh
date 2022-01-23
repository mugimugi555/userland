#!/bin/bash

# wget https://raw.githubusercontent.com/mugimugi555/userland/main/install_opencv.sh && bash install_opencv.sh ;

sudo apt update ;
sudo apt upgrade -y ;

sudo apt install -y build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev ;
    
cd ;
mkdir ~/opencv_build ;
cd ~/opencv_build ;
git clone https://github.com/opencv/opencv.git ;
git clone https://github.com/opencv/opencv_contrib.git ;
mkdir build ;
cd build ;

export LD_LIBRARY_PATH="" ;
# echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local-lib.conf ;
# ldconfig -v ;

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON .. ;
    
make -j2 ;

pkg-config --modversion opencv4 ;

echo export PYTHONPATH="/usr/local/lib/python3.7/site-packages:$PYTHONPATH" >> ~/.bash_profile ;
source ~/.bash_profile ;

python3 -c "import cv2; print(cv2.__version__)" ;
