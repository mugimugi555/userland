#!/usr/bin/bash

exit;

mkdir ~/.config/nginx ;
mkdir ~/.config/nginx/includes ;
mkdir ~/.config/nginx/tmp ;

touch ~/.config/nginx/nginx.conf ;
touch ~/.config/nginx/error.log ;
nano ~/.config/nginx/nginx.conf ;

error_log /home/user/.config/nginx/error.log info;
pid /dev/null;
events { worker_connections 128; }
http {
        include mimes.conf; #for custom file types
        default_type application/octet-stream;
        access_log /home/user/.config/nginx/access.log combined;

        client_body_temp_path /home/user/.config/nginx/tmp/client_body;
        proxy_temp_path /home/user/.config/nginx/tmp/proxy;
        fastcgi_temp_path /home/user/.config/nginx/tmp/fastcgi;
        uwsgi_temp_path /home/user/.config/nginx/tmp/uwsgi;
        scgi_temp_path /home/user/.config/nginx/tmp/scgi;

        server_tokens off;
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 4;

        output_buffers   1 32k;
        postpone_output  1460;

        server {
                listen 15954 default; #IPv4
                listen [::]:15954 default; #IPv6
                autoindex on; #this is the file list
                index index.php index.html;
                
                # path you want to share
                root /home/user/files/;
                
                # file with user:pass info
                auth_basic_user_file /home/user/.config/nginx/htpasswd.conf;
                auth_basic "Personal file server";
                
                # Any extra configuration
                include /home/user/.config/nginx/includes/*.conf;
        }
}


touch ~/.config/nginx/mimes.conf ;
nano ~/.config/nginx/mimes.conf ;
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


# touch ~/.config/nginx/htpasswd.conf ;
#  echo 'username:'$(crypt password) >> ~/.config/nginx/htpasswd.conf ;

touch ~/.config/nginx/start ;
chmod +x ~/.config/nginx/start ;
nano ~/.config/nginx/start ;

#!/bin/bash
# start
/usr/sbin/nginx -c ~/.config/nginx/nginx.conf &> /dev/null ;

crontab -e ;

@reboot ~/.config/nginx/start

nano ~/.config/nginx/stop ;
#!/bin/bash
# stop
pkill -f nginx/nginx.conf

# openssl req -new -x509 -nodes -out 
# ~/.config/nginx/server.crt -keyout ~/.config/nginx/server.key

nano nginx.conf ;

        listen 15954 ssl; # Replace existing line
        listen [::]:15954 ssl; # Replace existing line
        # ssl on;
        ssl_certificate /home/user/.config/nginx/server.crt;
        ssl_certificate_key /home/user/.config/nginx/server.key; 


mkdir ~/.config/php-fpm2
touch ~/.config/php-fpm2/conf

[global]
daemonize = yes
error_log = /home/user/.config/php-fpm2/error.log

[www]
listen = /home/user/.config/php-fpm2/socket

listen.owner = user
listen.group = user
listen.mode = 0600

pm = dynamic
pm.max_children = 20
pm.start_servers = 1
pm.min_spare_servers = 1
pm.max_spare_servers = 5


# start
php-fpm --fpm-config ~/.config/php-fpm2/conf

touch ~/.config/nginx/fastcgi_params

fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;

fastcgi_param  QUERY_STRING       $query_string;
fastcgi_param  REQUEST_METHOD     $request_method;
fastcgi_param  CONTENT_TYPE       $content_type;
fastcgi_param  CONTENT_LENGTH     $content_length;

fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
fastcgi_param  REQUEST_URI        $request_uri;
fastcgi_param  DOCUMENT_URI       $document_uri;
fastcgi_param  DOCUMENT_ROOT      $document_root;
fastcgi_param  SERVER_PROTOCOL    $server_protocol;

fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
fastcgi_param  SERVER_SOFTWARE    WebServer;

fastcgi_param  REMOTE_ADDR        $remote_addr;
fastcgi_param  REMOTE_PORT        $remote_port;
fastcgi_param  SERVER_ADDR        $server_addr;
fastcgi_param  SERVER_PORT        $server_port;
fastcgi_param  SERVER_NAME        $server_name;

fastcgi_connect_timeout 60;
fastcgi_send_timeout 180;
fastcgi_read_timeout 180;
fastcgi_buffer_size 128k;
fastcgi_buffers 8 256k;
fastcgi_busy_buffers_size 256k;
fastcgi_temp_file_write_size 256k;
fastcgi_intercept_errors on;


touch ~/.config/nginx/includes/php.conf

location ~ \.php$ {
    include fastcgi_params;
    fastcgi_pass unix:/home/user/.config/php-fpm2/socket;
}

pkill -f nginx/nginx.conf && ~/.config/nginx/start ;

