#!/usr/bin/bash

# sudo apt update ; sudo apt install -y wget ; wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_bullseye.sh && bash install_bullseye.sh ;

sudo cp /etc/apt/sources.list /etc/apt/sources.list.back ;

NEWSOURCELIST=$(cat<<TEXT
deb http://ftp.jp.debian.org/debian/ bullseye main contrib non-free
deb-src http://ftp.jp.debian.org/debian/ bullseye main contrib non-free

deb http://ftp.jp.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://ftp.jp.debian.org/debian/ bullseye-updates main contrib non-free

deb http://security.debian.org/ bullseye-security main
deb-src http://security.debian.org/ bullseye-security main
TEXT
)
sudo echo "$NEWSOURCELIST" | sudo tee /etc/apt/sources.list ;

sudo apt update ;
sudo apt upgrade -y ;
sudo apt full-upgrade -y ;
# apt upgrade --without-new-pkgs
sudo apt autoremove -y ;
