#!/bin/bash

#
sudo apt update ;
sudo apt upgrade -y ;

#
sudo apt install -y git curl htop net-tools emacs-nox lame unar axel vlc gedit build-essential ffmpeg imagemagick ;
sudo apt install -y chromium ;
#sudo apt install -y handbrake ;
#sudo apt install -y inetutils-ping ;
#sudo apt install -y kdenlive ;

#
sudo apt install -y fonts-takao-pgothic fonts-takao-gothic fonts-takao-mincho ;
sudo apt install -y locales ;
#sudo dpkg-reconfigure locales ;
export LANG=ja_JP.UTF-8 ;
echo "export LANG=ja_JP.UTF-8" >> ~/.profile ;

#
sudo rm /etc/localtime ;
sudo echo Asia/Tokyo > /etc/timezone ;
sudo dpkg-reconfigure -f noninteractive tzdata ;

#
sudo apt install -y gimp ;
sudo apt install -y gtk2-engines-pixbuf ;
sudo apt install -y libcanberra-gtk* ;

#
sudo apt install -y python3-pip ;
sudo -H pip install --upgrade youtube-dl ;
