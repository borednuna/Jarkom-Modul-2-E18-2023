# Jarkom-Modul-2-E18-2023

Anggota Kelompok ''E18'' 
| Nama                      | NRP        |
|---------------------------|------------|
| Hanun Shaka Puspa         | 5025211051 |
| Cholid Junoto             | 5025201038 |

# Topologi
![topologi](./img/topologi.jpeg)

# Konfigurasi Setiap Node
## Router
```
auto eth0
iface eth0 inet dhcp
auto eth1
iface eth1 inet static
    address 192.215.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.215.2.1
    netmask 255.255.255.0
```

## NakulaClient
```
auto eth0
iface eth0 inet static
    address 192.215.1.2
    netmask 255.255.255.0
    gateway 192.215.1.1
```

## SadewaClient
```
auto eth0
iface eth0 inet static
    address 192.215.1.3
    netmask 255.255.255.0
    gateway 192.215.1.1
```

## AbimanyuWebServer
```
auto eth0
iface eth0 inet static
    address 192.215.1.4
    netmask 255.255.255.0
    gateway 192.215.1.1
```

## PrabukusumaWebServer
```
auto eth0
iface eth0 inet static
	address 192.215.1.5
	netmask 255.255.255.0
	gateway 192.215.1.1
```

## WisanggeniWebServer
```
auto eth0
iface eth0 inet static
    address 192.215.1.6
    netmask 255.255.255.0
    gateway 192.215.1.1
```

## YudhistiraDNSMaster
```
auto eth0
iface eth0 inet static
	address 192.215.2.2
	netmask 255.255.255.0
	gateway 192.215.2.1
```

## WerkudaraDNSSlave
```
auto eth0
iface eth0 inet static
    address 192.215.2.3
    netmask 255.255.255.0
    gateway 192.215.2.1
```

## ArjunaLoadBalancer
```
auto eth0
iface eth0 inet static
    address 192.215.2.4
    netmask 255.255.255.0
    gateway 192.215.2.1
```
