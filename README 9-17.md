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

jangan lupa lakukan perintah ```rm /etc/nginx/sites-enabled/default``` untuk menghapus file ```default``` supaya tidak bertabrakan pada saat kta melakukan installasi ```nginx``

kemudian lakukan restart ```nginx``` dengan cara ```service nginx restart```

Selanjutnya pada worker (Prabukusuma, Abimanyu, dan Wisanggeni) jalan kan perintah:
```service php7.0-fpm start

echo 'server {
        listen 80;

        root /var/www/jarkom;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom

rm /etc/nginx/sites-enabled/default

service nginx restart```

Setelah selesai di jalankan, kita dapat melakukan perintah:
```lynx http://arjuna.e18.com``` pada semua client


## Soal 10
Kemudian gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh
    - Prabakusuma:8001
    - Abimanyu:8002
    - Wisanggeni:8003

Pada soal nomor 10 kita hanya menambahkan port pada masing-masing worker (Prabakusuma:8001, Abimanyu:8002, Wisanggeni:8003)   selain itu  kita menambahkan :800X pada masing-masing server (X adalah nilai byte ke-3 pada masing masing worker)

```echo '
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
}' > /etc/nginx/sites-available/jarkom```

### Client
pada client lakukan installasi ```lynx``
```
apt-get update
apt-get install lynx -y
```
kemudian jalankan perintah
```lynx http://arjuna.e18.com```
