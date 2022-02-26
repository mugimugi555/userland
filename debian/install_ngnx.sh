#!/usr/bin/bash

# 

wget http://nginx.org/keys/nginx_signing.key ;
sudo apt-key add nginx_signing.key ;

sudo touch /etc/apt/sources.list.d/nginx.list ;
VERSION_CODENAME=$(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME') ;
echo $VERSION_CODENAME ;
echo "deb http://nginx.org/packages/debian/ $VERSION_CODENAME nginx" | sudo tee /etc/apt/sources.list.d/nginx.list ;
echo "deb-src http://nginx.org/packages/debian/ $VERSION_CODENAME nginx" | sudo tee -a /etc/apt/sources.list.d/nginx.list ;
cat /etc/apt/sources.list.d/nginx.list ;

sudo apt update ;
sudo apt install -y nginx ;
