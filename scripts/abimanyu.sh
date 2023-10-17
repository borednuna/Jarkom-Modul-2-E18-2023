
#--nomor3--

apt-get update
apt-get install bind9 -y

#buat domain local
echo'
zone "abimanyu.e18.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.e18.com";
};
'> /etc/bind/named.conf.local
#buat folder jarkom
mkdir /etc/bind/jarkom
#copy db local ke folder jarkom dengan nama file abimanyu.e18.com
cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.e18.com
#masukkan konfigurasi berikut
echo'
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.e18.com. root.abimanyu.e18.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.e18.com.
@       IN      A       192.215.1.4
@       IN      AAAA    ::1
www     IN      CNAME   abimanyu.e18.com.
' > /etc/bind/jarkom/abimanyu.e18.com
#restart Bind9
service bind9 restart

#---nomor 11---
#
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.e18.com.conf
#hapus file default
rm /etc/apache2/sites-available/000-default.conf
#isikan configurasi berikut pada file abimanyu.e18.com.conf
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.e18

  ServerName abimanyu.e18.com
  ServerAlias www.abimanyu.e18.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.e18.com.conf

a2ensite abimanyu.e18.com.conf
#restart apache2
service apache2 restart

#--nomor 12---
#lakukan configurasi berikut di dalam file abimanyu.e18.com.conf
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.e18
  ServerName abimanyu.e18.com
  ServerAlias www.abimanyu.e18.com

  <Directory /var/www/abimanyu.e18/index.php/home>
          Options +Indexes
  </Directory>

  Alias "/home" "/var/www/abimanyu.e18/index.php/home"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.e18.com.conf
#lakukan restart apache2
service apache2 restart

#--nomor 13--
#lakukan setup server name menjadi alias /etc/apache2/sites-available/parikesit.abimanyu.e18.com.conf
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.e18
  ServerName parikesit.abimanyu.e18.com
  ServerAlias www.parikesit.abimanyu.e18.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.e18.com.conf

a2ensite parikesit.abimanyu.e18.com.conf
#lakukan restart apache2
service apache2 restart

#---nomor 14---
#lakukan konfigurasi berikut Options+Indexes untuk mengizinkan public melakukan listing
#Options-Indexes untuk menutup folder
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.e18
  ServerName parikesit.abimanyu.e18.com
  ServerAlias www.parikesit.abimanyu.e18.com

  <Directory /var/www/parikesit.abimanyu.e18/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.e18/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.e18/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.e18/secret"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.e18.com.conf
#restart apache2
service apache2 restart

#---Nomor 15 ---
#pada parikesit.abimanyu.e18.com/public/error/ terdapat dua file eror yaitu 404.html dan 403.html
#ErrorDocument di gunakan untuk melakukan redirect terhadap file yang di inginkan saat bermasalah waktu mengakses domain sebelumnya
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.e18
  ServerName parikesit.abimanyu.e18.com
  ServerAlias www.parikesit.abimanyu.e18.com

  <Directory /var/www/parikesit.abimanyu.e18/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.e18/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.e18/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.e18/secret"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.e18.com.conf
#restart aoache2
service apache2 restart

#---nomor 16---
#tambahkan Alias "/js" "/var/www/parikesit.abimanyu.e18/public/js" untuk konfigurasi virtual host

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.e18
  ServerName parikesit.abimanyu.e18.com
  ServerAlias www.parikesit.abimanyu.e18.com

  <Directory /var/www/parikesit.abimanyu.e18/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.e18/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.e18/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.e18/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.e18/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.e18.com.conf

#--nomor 17--
#tambahkan Listen 14000 dan Listen 14400 pada file ports.conf. tidak lupa mengubah VitualHost menjadi <VirtualHost *:14000 *:14400>
echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.e18
  ServerName rjp.baratayuda.abimanyu.e18.com
  ServerAlias www.rjp.baratayuda.abimanyu.e18.com

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.e18.com.conf

#buka /etc/apache2/ports.conf tambahkan konfigurasi seperti di bawah
echo -e '# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf

a2ensite rjp.baratayuda.abimanyu.e18.com.conf

#restart apache2
service apache2 restart


