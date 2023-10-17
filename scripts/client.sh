#nomor2
echo'
nameserver 192.215.2.4' > /etc/resolv.conf

#lakukan ping
ping arjuna.e18.com
ping www.arjuna.e18.com

#nomor3
echo'
nameserver 192.215.1.4' > /etc/resolv.conf

#lakukan ping
ping abimanyu.e18.com
ping www.abimanyu.e18.com

#nomor4
echo'
nameserver 192.215.2.2' > /etc/resolv.conf
#lakukan ping
ping parikesit.abimanyu.e18.com

#nomor5
echo'
nameserver 192.168.122.1' > /etc/resolv.conf #ip route
#install dnsutils
apt-get update
apt-get install dnsutils -y
#kembalikan ip yudhistira
echo'
nameserver 192.215.2.2' > /etc/resolv.conf #ip yudhistira

#cara ngetes
host -t PTR 192.215.2.2

#nomor6
echo'
nameserver 192.215.2.2
nameserver 192.215.2.3' > /etc/resolv.conf #ip yudhistira dan werkudara


#nomor 10
#install lynx
apt-get update
apt-get install lynx -y
#jalankan perintah
lynx http://arjuna.e18.com

#nomor 11
#pada client jalankan perintah
lynx abimanyu.e18.com


#nomor 12
#jalankan perintah
lynx abimanyu.e18.com/home
curl abimanyu.e18.com/home

#nomor13
#jalankan perintah
lynx parikesit.abimanyu.e18.com
curl parikesit.abimanyu.e18.com

#nomor14
lynx parikesit.abimanyu.e18.com/public
lynx parikesit.abimanyu.e18.com/secret

#nomor15
lynx parikesit.abimanyu.e18.com/testerror
lynx parikesit.abimanyu.e18.com/secret

#nomor16
lynx parikesit.abimanyu.e18.com/js
#nomor17
lynx rjp.baratayuda.abimanyu.e18.com:14000
lynx rjp.baratayuda.abimanyu.e18.com:14400

