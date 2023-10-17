#---Nomor2---
apt-get update
apt-get install bind9 -y

#buat domain local
echo'
zone "arjuna.e18.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.e18.com";
};
'> /etc/bind/named.conf.local
#buat folder jarkom
mkdir /etc/bind/jarkom
#copy db local ke folder jarkom dengan nama file arjuna.e18.com
cp /etc/bind/db.local /etc/bind/jarkom/arjuna.e18.com
#masukkan konfigurasi berikut
echo'
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.e18.com. root.arjuna.e18.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.e18.com.
@       IN      A       192.215.2.4
@       IN      AAAA    ::1
www     IN      CNAME   arjuna.e18.com.
' > /etc/bind/jarkom/arjuna.e18.com
#restart Bind9
service bind9 restart

#--nomor9---
#install nginx
apt-get update
apt-get install nginx -y

service nginx start
#ke worker>> abimanyu,prabukusuma, wisanggeni

#---nomor10--
# masukkan konfigurasi roundrobin
echo '
upstream myweb {
        server 192.215.1.5:8001; #prabukusuma
        server 192.215.1.4:8002; #abimanyu
        server 192.215.1.6:8003; #wisanggeni
}

server {
    listen 80;
    
    server_name arjuna.e18.com www.arjuna.e18.com;

    location / {
        proxy_pass http://myweb;
    }
}' > /etc/nginx/sites-available/jarkom

#buat symlink
 ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled
#ke client: nakula, sadewa

#---nomor 11 ---

