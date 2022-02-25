#!/usr/bin/bash

#

VERSION_CODENAME=$(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME') ;

sudo apt install -y gnupg2 ca-certificates apt-transport-https software-properties-common ;
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add - ;
echo "deb https://packages.sury.org/php/ $VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/php.list ;

sudo apt update ;
sudo apt install -y php8.1 php8.1-fpm ;
