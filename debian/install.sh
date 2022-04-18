#!/bin/bash

# wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install.sh && bash install.sh ;

# ======================================================================================================================
# set link to sd card
# ======================================================================================================================
ln -s /host-rootfs/sdcard ~/ ;

# ======================================================================================================================
# auto start ssh server port 2022 in vnc mode
# ======================================================================================================================
echo "sudo bash /support/startSSHServer.sh" | sudo tee -a /support/startVNCServer.sh ;

# ======================================================================================================================
# one liner command
# ======================================================================================================================
# sudo apt update -y ; sudo apt install -y wget ; wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install.sh && bash install.sh ;

# ======================================================================================================================
# update
# ======================================================================================================================
sudo apt update ;
sudo apt upgrade -y ;

# ======================================================================================================================
# common
# ======================================================================================================================
sudo apt install -y wget git curl htop net-tools emacs-nox lame unar axel vlc gedit build-essential ffmpeg imagemagick ;
#sudo apt install -y handbrake ;
#sudo apt install -y inetutils-ping ;
#sudo apt install -y kdenlive ;

# ======================================================================================================================
# libreoffice
# ======================================================================================================================
#sudo apt install -y libreoffice libreoffice-l10n-ja libreoffice-dmaths libreoffice-ogltrans libreoffice-writer2xhtml libreoffice-pdfimport libreoffice-help-ja ;

# ======================================================================================================================
# chrome
# ======================================================================================================================
sudo apt install -y chromium ;
echo "alias chrome='chromium --no-sandbox'" >> ~/.profile ;
source ~/.profile ;

# ======================================================================================================================
# gimp
# ======================================================================================================================
sudo apt install -y gimp ;
sudo apt install -y gtk2-engines-pixbuf ;
sudo apt install -y libcanberra-gtk* ;

# ======================================================================================================================
# youtube
# ======================================================================================================================
sudo apt install -y python3-pip ;
sudo -H pip install --upgrade youtube-dl ;

# ======================================================================================================================
# local
# ======================================================================================================================
# timezone
sudo rm /etc/localtime ;
sudo echo Asia/Tokyo > /etc/timezone ;
sudo dpkg-reconfigure -f noninteractive tzdata ;

# japanese
sudo apt install -y fonts-takao-pgothic fonts-takao-gothic fonts-takao-mincho ;
sudo apt install -y locales ;
update-locale LANG=ja_JP.UTF-8 ;
locale-gen --purge "ja_JP.UTF-8" ;
sudo dpkg-reconfigure --frontend noninteractive locales ;
export LANG=ja_JP.UTF-8 ;
echo "export LANG=ja_JP.UTF-8" >> ~/.profile ;

# ======================================================================================================================
# finish
# ======================================================================================================================
echo "===========================";
echo "Please Reboot Userland App" ;
echo "===========================";
