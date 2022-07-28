#!/usr/bin/bash

exit;

# wget https://github.com/mugimugi555/userland/raw/main/debian/install_dock.sh && bash install_dock.sh ;

# https://linuxhint.com/custom-dock-xfce/
sudo apt install -y gnupg2 ca-certificates apt-transport-https software-properties-common ;
sudo add-apt-repository ppa:xubuntu-dev/extras ;
sudo apt update ;
sudo apt install -y xfce4-docklike-plugin ;
