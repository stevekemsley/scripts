#!/bin/bash

echo " * Installing openvpn "
apt install openvpn -y 
echo " * Installing client.conf"
cat << EOF > /etc/openvpn/client.conf
client
dev tun
proto tcp

remote <ipaddress> <port>

ncp-ciphers AES-128-GCM:AES-256-GCM:AES-128-CBC:AES-256-CBC

#auth-user-pass /etc/openvpn/pass.txt

resolv-retry infinite
nobind
persist-key
persist-tun

ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/<cert>.crt
key /etc/openvpn/keys/<cert>.key

log-append /var/log/openvpn.log

ns-cert-type server
verb 3

EOF

if [ -e /etc/openvpn/keys ];then
	echo " * Keys directory exists"
else
	echo " * Creating keys directory"
	mkdir /etc/openvpn/keys
fi

echo " * Now place keys in keys directory and configure /etc/client.conf"

exit 0


