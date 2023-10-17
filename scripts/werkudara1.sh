#--nomor6---
apt-get update
apt-get install bind9 -y
#config pada etc/bind/named.conf.local
echo 'zone "abimanyu.e18.com" {
    type slave;
    masters { 192.215.2.2; };
    file "/var/lib/bind/abimanyu.e18.com";
};

zone "baratayuda.abimanyu.e18.com"{
    type master;
    file "/etc/bind/baratayuda/baratayuda.abimanyu.e18.com";
};' > /etc/bind/named.conf.local

service bind9 restart

echo 'options{
        directory "/var/cache/bind";
        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6{ any; };
};' > /etc/bind/named.conf.options

mkdir /etc/bind/baratayuda

echo '
;
; BIND data file for local loopback interface
;
$TTL  604800
@   IN      SOA     baratayuda.abimanyu.e18.com.  root.baratayuda.abimanyu.e18.com. (
                    2022100601      ; Serial
                        604800      ; Refresh
                        86400       ; Retry 
                        2419200     ; Expire
                        604800  )   ; Negative Cache TTL
;
@   IN      NS      baratayuda.abimanyu.e18.com.
@   IN      A       192.215.1.4       ;
www IN      CNAME   baratayuda.abimanyu.e18.com.
rjp IN      A       192.215.1.4       ;
www.rjp IN  CNAME   rjp.baratayuda.abimanyu.e18.com.
' > /etc/bind/baratayuda/baratayuda.abimanyu.e18.com

service bind9 restart
