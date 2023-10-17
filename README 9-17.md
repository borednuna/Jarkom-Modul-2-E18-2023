# Jarkom-Modul-2-E18-2023
## Soal 9
Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.
### Arjuna
```
#lakukan installasi nginx
apt-get update
apt-get install nginx -y
service nginx start
```
Buat load balancing sebagai berikut menggunakan algoritma round-robin:
```echo '
upstream myweb {
        server 192.215.1.5; #prabukusuma
        server 192.215.1.4; #abimanyu
        server 192.215.1.6; #wisanggeni
}

server {
    listen 80;
    
    server_name arjuna.e18.com www.arjuna.e18.com;

    location / {
        proxy_pass http://myweb;
    }
}' > /etc/nginx/sites-available/jarkom
```
Setelah selesai lakukan perintah ```symlink``` dengan perintah sebagai berikut:
```ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom```
