#!/usr/bin/bash

# sudo apt update ; sudo apt install -y wget ; wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_php81.sh && bash install_php81.sh ;

VERSION_CODENAME=$(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME') ;

sudo apt install -y gnupg2 ca-certificates apt-transport-https software-properties-common ;
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add - ;
echo "deb https://packages.sury.org/php/ $VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/php.list ;

sudo apt update ;
sudo apt install -y php8.1 php8.1-fpm ;
