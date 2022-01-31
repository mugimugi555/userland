#!/usr/bin/bash

# wget https://raw.githubusercontent.com/mugimugi555/userland/main/ubuntu/install_rails.sh && install_rails.sh ;

# install rbenv
cd ;
sudo apt update ;
sudo apt install -y git-all ;
git clone https://github.com/rbenv/rbenv.git ~/.rbenv ;
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile ;
~/.rbenv/bin/rbenv init ;
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile ;
source .bash_profile ;
mkdir -p "$(rbenv root)"/plugins ;
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build ;
sudo apt install -y \
	autoconf bison build-essential libssl-dev \
	libyaml-dev libreadline6-dev zlib1g-dev \
	libncurses5-dev libffi-dev libgdbm6 libgdbm-dev ;
rbenv install 3.1.0 ;
rbenv install 3.0.3 ;
rbenv install 2.7.5 ;
ruby -v ;
rbenv versions ;
rbenv global 3.1.0 ;

# install nodejs latest
cd ;
wget https://raw.githubusercontent.com/mugimugi555/ubuntu/main/install_nodejs.sh && bash install_nodejs.sh ;

# install misc
sudo apt install yarn ;
sudo apt install -y sqlite3 libsqlite3-dev ;

# install rails 7
gem install rails ;
rails new blog ;
cd blog ;
IPADDRESS=`hostname -I | awk -F" " '{print $1}'` ;
bin/rails server -b $IPADDRESS -p 8081 ;
