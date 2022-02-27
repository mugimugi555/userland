#!/bin/bash

# ======================================================================================================================
# one liner command
# ======================================================================================================================
# sudo apt update -y ; sudo apt install -y wget ; wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_laravel.sh && bash install_laravel.sh ;

# ======================================================================================================================
# install laravel libraries
# ======================================================================================================================
sudo echo ;
sudo apt install -y apache2 php php-xml php-bcmath php-mbstring php-xml php-zip mariadb-server ;

# ======================================================================================================================
# install composer
# ======================================================================================================================
cd ;
php -r "copy ( 'https://getcomposer.org/installer', 'composer-setup.php' ) ;" ;
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer ;
composer -v ;

# ======================================================================================================================
# create html dir on home dir
# ======================================================================================================================
sudo mv /var/www/html/ /var/www/html_back ;
mkdir ~/html ;
sudo ln -s /home/$USER/html/ /var/www/html ;
echo "hi" > ~/html/index.html ;

# ======================================================================================================================
# create laravel project
# ======================================================================================================================
composer global require laravel/installer ;
PATH="$PATH:$HOME/bin:$HOME/.config/composer/vendor/bin" ;
source .profile ;
laravel new testproject ;
sudo chown www-data:www-data -R testproject/storage testproject/bootstrap/cache ;
ln -s /home/$USER/testproject/public /var/www/html/testproject ;
