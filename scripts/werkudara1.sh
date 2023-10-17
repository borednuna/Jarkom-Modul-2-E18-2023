#--nomor6---
apt-get update
apt-get install bind9 -y
#config pada etc/bind/named.conf.local
echo 'zone "abimanyu.e18.com" {
    type slave;
    masters { 192.215.2.2; }; //ip yudhistira
    file "/var/lib/bind/abimanyu.e18.com";
};' > etc/bind/named.conf.local

service bind9 restart
#Ke yudhistira >>

