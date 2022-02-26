#!/usr/bin/bash

# sudo apt update ; sudo apt install -y wget ; wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_nginx_php81.sh && bash install_nginx_php81.sh ;

if ! [ -x "$(command -v wget)" ]; then
  sudo apt update ;
  sudo apt install -y wget ; 
fi

wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_nginx.sh && bash install_nginx.sh ;
wget https://raw.githubusercontent.com/mugimugi555/userland/main/debian/install_php81.sh && bash install_php81.sh ;

sudo apt install -y libc6-dev ;

mkdir ~/www ;

mkdir ~/.config/nginx ;
mkdir ~/.config/nginx/includes ;
mkdir ~/.config/nginx/tmp ;
touch ~/.config/nginx/nginx.conf ;
touch ~/.config/nginx/error.log ;

NGINX_CONF=$(cat<<TEXT
error_log /home/$USER/.config/nginx/error.log info;
pid /dev/null;
events { worker_connections 128; }
http {
        include mimes.conf; #for custom file types
        default_type application/octet-stream;
        access_log /home/$USER/.config/nginx/access.log combined;

        client_body_temp_path /home/$USER/.config/nginx/tmp/client_body;
        proxy_temp_path /home/$USER/.config/nginx/tmp/proxy;
        fastcgi_temp_path /home/$USER/.config/nginx/tmp/fastcgi;
        uwsgi_temp_path /home/$USER/.config/nginx/tmp/uwsgi;
        scgi_temp_path /home/$USER/.config/nginx/tmp/scgi;

        server_tokens off;
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 4;

        output_buffers   1 32k;
        postpone_output  1460;

        server {
                listen 8081 default; #IPv4
                listen [::]:8081 default; #IPv6
                autoindex on; #this is the file list
                index index.php index.html;
                
                # path you want to share
                root /home/$USER/www/;
                
                # file with user:pass info
                #auth_basic_user_file /home/$USER/.config/nginx/htpasswd.conf;
                #auth_basic "Personal file server";
                
                # Any extra configuration
                include /home/$USER/.config/nginx/includes/*.conf;
        }
}
TEXT
)
echo "$NGINX_CONF" > ~/.config/nginx/nginx.conf ;

touch ~/.config/nginx/mimes.conf ;
NGINX_MIMES=$(cat<<TEXT
types {
    text/html                             html htm shtml;
    text/css                              css;
    text/xml                              xml;
    image/gif                             gif;
    image/jpeg                            jpeg jpg;
    application/x-javascript              js;
    application/atom+xml                  atom;
    application/rss+xml                   rss;

    font/opentype             otf;

    text/mathml                           mml;
    text/plain                            txt;
    text/vnd.sun.j2me.app-descriptor      jad;
    text/vnd.wap.wml                      wml;
    text/x-component                      htc;

    image/png                             png;
    image/tiff                            tif tiff;
    image/vnd.wap.wbmp                    wbmp;
    image/x-icon                          ico;
    image/x-jng                           jng;
    image/x-ms-bmp                        bmp;
    image/svg+xml                         svg;

    application/java-archive              jar war ear;
    application/mac-binhex40              hqx;
    application/msword                    doc;
    application/pdf                       pdf;
    application/postscript                ps eps ai;
    application/rtf                       rtf;
    application/vnd.ms-excel              xls;
    application/vnd.ms-powerpoint         ppt;
    application/vnd.wap.wmlc              wmlc;
    application/vnd.wap.xhtml+xml         xhtml;
    application/vnd.google-earth.kml+xml  kml;
    application/vnd.google-earth.kmz      kmz;
    application/x-7z-compressed           7z;
    application/x-cocoa                   cco;
    application/x-java-archive-diff       jardiff;
    application/x-java-jnlp-file          jnlp;
    application/x-makeself                run;
    application/x-perl                    pl pm;
    application/x-pilot                   prc pdb;
    application/x-rar-compressed          rar;
    application/x-redhat-package-manager  rpm;
    application/x-sea                     sea;
    application/x-shockwave-flash         swf;
    application/x-stuffit                 sit;
    application/x-tcl                     tcl tk;
    application/x-x509-ca-cert            der pem crt;
    application/x-xpinstall               xpi;
    application/zip                       zip;

    application/octet-stream              bin exe dll;
    application/octet-stream              deb;
    application/octet-stream              dmg;
    application/octet-stream              eot;
    application/octet-stream              iso img;
    application/octet-stream              msi msp msm;

    audio/midi                            mid midi kar;
    audio/mpeg                            mp3;
    audio/x-realaudio                     ra;

    video/3gpp                            3gpp 3gp;
    video/mpeg                            mpeg mpg;
    video/quicktime                       mov;
    video/x-flv                           flv;
    video/x-mng                           mng;
    video/x-ms-asf                        asx asf;
    video/x-ms-wmv                        wmv;
    video/x-msvideo                       avi;
        
    application/x-bittorrent              torrent;
}
TEXT
)
echo "$NGINX_MIMES" > ~/.config/nginx/mimes.conf ;

# touch ~/.config/nginx/htpasswd.conf ;
# echo 'username:'$(crypt password) >> ~/.config/nginx/htpasswd.conf ;

touch ~/.config/nginx/start ;
chmod +x ~/.config/nginx/start ;
NGINX_START=$(cat<<TEXT
#!/bin/bash
# start
LD_LIBRARY_PATH="" ;
/usr/sbin/nginx -c ~/.config/nginx/nginx.conf &> /dev/null ;
TEXT
)
echo "$NGINX_START" > ~/.config/nginx/start ;

touch ~/.config/nginx/stop ;
chmod +x ~/.config/nginx/stop ;
NGINX_STOP=$(cat<<TEXT
#!/bin/bash
# stop
pkill -f nginx/nginx.conf
TEXT
)
echo "$NGINX_STOP" > ~/.config/nginx/stop ;

# echo "@reboot ~/.config/nginx/start" | crontab -
#
# openssl req -new -x509 -nodes -out 
# ~/.config/nginx/server.crt -keyout ~/.config/nginx/server.key
#
#nano nginx.conf ;
#
#        listen 8088 ssl; # Replace existing line
#        listen [::]:8088 ssl; # Replace existing line
#        # ssl on;
#        ssl_certificate /home/$USER/.config/nginx/server.crt;
#        ssl_certificate_key /home/$USER/.config/nginx/server.key; 

mkdir ~/.config/php-fpm ;
touch ~/.config/php-fpm/conf ;
PHP_CONF=$(cat<<TEXT
[global]
daemonize = yes
error_log = /home/$USER/.config/php-fpm/error.log

[www]
listen = /home/$USER/.config/php-fpm/socket

listen.owner = $USER
listen.group = $USER
listen.mode = 0600

pm = dynamic
pm.max_children = 20
pm.start_servers = 1
pm.min_spare_servers = 1
pm.max_spare_servers = 5
TEXT
)
echo "$PHP_CONF" > ~/.config/php-fpm/conf ;

touch ~/.config/php-fpm/start ;
chmod +x ~/.config/php-fpm/start ;
PHP_START=$(cat<<TEXT
#!/bin/bash
# start
php-fpm8.1 --fpm-config ~/.config/php-fpm/conf ;
TEXT
)
echo "$PHP_START" > ~/.config/php-fpm/start ;

touch ~/.config/php-fpm/stop ;
chmod +x ~/.config/php-fpm/stop ;
PHP_STOP=$(cat<<TEXT
#!/bin/bash
# stop
pkill php-fpm
TEXT
)
echo "$PHP_STOP" > ~/.config/php-fpm/stop ;

touch ~/.config/nginx/fastcgi_params ;
PHP_CONF=$(cat<<TEXT
fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;

fastcgi_param  QUERY_STRING       \$query_string;
fastcgi_param  REQUEST_METHOD     \$request_method;
fastcgi_param  CONTENT_TYPE       \$content_type;
fastcgi_param  CONTENT_LENGTH     \$content_length;

fastcgi_param  SCRIPT_NAME        \$fastcgi_script_name;
fastcgi_param  REQUEST_URI        \$request_uri;
fastcgi_param  DOCUMENT_URI       \$document_uri;
fastcgi_param  DOCUMENT_ROOT      \$document_root;
fastcgi_param  SERVER_PROTOCOL    \$server_protocol;

fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
fastcgi_param  SERVER_SOFTWARE    WebServer;

fastcgi_param  REMOTE_ADDR        \$remote_addr;
fastcgi_param  REMOTE_PORT        \$remote_port;
fastcgi_param  SERVER_ADDR        \$server_addr;
fastcgi_param  SERVER_PORT        \$server_port;
fastcgi_param  SERVER_NAME        \$server_name;

fastcgi_connect_timeout 60;
fastcgi_send_timeout 180;
fastcgi_read_timeout 180;
fastcgi_buffer_size 128k;
fastcgi_buffers 8 256k;
fastcgi_busy_buffers_size 256k;
fastcgi_temp_file_write_size 256k;
fastcgi_intercept_errors on;
TEXT
)
echo "$PHP_CONF" > ~/.config/nginx/fastcgi_params ;

touch ~/.config/nginx/includes/php.conf ;
PHP_SOCKET=$(cat<<TEXT
location ~ \.php\$ {
    include fastcgi_params;
    fastcgi_pass unix:/home/$USER/.config/php-fpm/socket;
}
TEXT
)
echo "$PHP_SOCKET" > ~/.config/nginx/includes/php.conf ;

~/.config/php-fpm/stop ;
~/.config/nginx/stop ;
~/.config/php-fpm/start ;
~/.config/nginx/start ;

echo "~/.config/php-fpm/start" | sudo tee -a /support/startVNCServerStep2.sh ;
echo "~/.config/nginx/start" | sudo tee -a /support/startVNCServerStep2.sh ;

echo "<php phpinfo(); " > ~/www/index.php ;
IPADDRESS=$( hostname -I | cut -f1 -d' ' ) ;

echo "===============================";
echo "please visit =>";
echo "http://$IPADDRESS:8081/";
echo "===============================";
