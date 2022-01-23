#!/bin/bash

# wget https://raw.githubusercontent.com/mugimugi555/userland/main/install_tflite.sh && bash install_tflite.sh ;

#
sudo apt update ;
sudo apt upgrade -y ;
sudo apt install -y python3-pip ;

#
pip3 install --extra-index-url https://google-coral.github.io/py-repo/ tflite_runtime ;

#
python3 -c 'import tflite_runtime as tf; print(tf.__version__)' ;
