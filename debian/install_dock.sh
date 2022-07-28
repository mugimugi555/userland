#!/usr/bin/bash

# wget https://github.com/mugimugi555/userland/raw/main/debian/install_dock.sh && bash install_dock.sh ;

# https://linuxhint.com/custom-dock-xfce/
sudo add-apt-repository ppa:xubuntu-dev/extras ;
sudo apt update ;
sudo apt install -y xfce4-docklike-plugin ;
