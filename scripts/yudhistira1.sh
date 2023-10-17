#--Nomor4--
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
@       IN      A       192.215.2.2 ;ip yudhistira
parikesit   IN  A       192.215.1.4 ;ip abimanyu
@       IN      AAAA    ::1
' > /etc/bind/jarkom/abimanyu.e18.com
#restart Bind9
service bind9 restart
#--nomor5--
#tambahkan konfigurasi berikut
echo'
zone "2.215.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/2.215.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/jarkom/2.215.192.in-addr.arpa

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
2.215.192.in-addr.arpa.    IN  NS  abimanyu.e18.com.
2   IN  PTR    abimanyu.e18.com. ;byte ke-4 ip yudhistira
' > /etc/bind/jarkom/abimanyu.e18.com
#restart Bind9
service bind9 restart

#--nomor6 ---
#tambahkan
echo'
zone "abimanyu.e18.com" {
	type master;
    also-notify { 192.215.2.3; }; //IP Werkudara
	file "/etc/bind/jarkom/abimanyu.e18.com";
    allow-transfer { 192.215.2.3; }; //IP Werkudara
};' > /etc/bind/named.conf.local

#lakukan restart
service bind9 restart
#ke werkudara>>
service bind9 stop #matika service
#ke client>>

#--Nomor 11---
#di dalam yudhistira sebagai DNS master lakukan konfigurasi sebagai berikut
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
apt-get install nginx -y
service nginx start
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
service apache2 start
apt-get install wget -y
apt-get install unzip -y
apt-get install php -y
echo -e "\n\nPHP Version:"
php -v

#lakukan konfigurasi berikut mengubah ip dari werkudara ke abimanyu
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.e18.com. root.abimanyu.e18.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.e18.com.
@       IN      A       192.215.1.4     ; IP Abimanyu
www     IN      CNAME   abimanyu.e18.com.
parikesit IN    A       192.215.1.4     ; IP Abimanyu
ns1     IN      A       192.215.2.3     ; IP Werkudara
baratayuda IN   NS      ns1' > /etc/bind/jarkom/abimanyu.e18.com

#lakukan restart bind9
service bind9 restart
#ke abimanyu>>>
