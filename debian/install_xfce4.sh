#/usr/bin/bash

sudo apt update -y ;
sudo apt upgrade -y ;
sudo apt install -y xfce4 ;
#sudo apt install -y xfce4-goodies ;

sudo update-alternatives --config x-session-manager ;
