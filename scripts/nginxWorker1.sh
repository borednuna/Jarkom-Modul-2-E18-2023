#---nomor9--
#install nginx, php, dan apache2
apt-get update 
apt install nginx php php-fpm apache2 libapache2-mod-php7.2 -y

#start 
service nginx start
service php7.2-fpm start

#buat direktori
mkdir /var/www/jarkom

#buat file index.php dan masukkan script
echo'
<?php
 echo "Halo, Kamu berada di "isikan nama worker";
 ?>'> /var/www/jarkom/index.php
#buat file jarkom pada /etc/nginx/sites-available dan masukkan script
echo'
 server {

 	listen 80;

 	root /var/www/jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/jarkom_error.log;
 	access_log /var/log/nginx/jarkom_access.log;
 }'> /etc/nginx/sites-available/jarkom

#buat symlink
 ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled
#restart nginx
service nginx restart
#cek apakah konfigurasi yang dibuat sudah benar
nginx -t

