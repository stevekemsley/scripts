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

#http-proxy-retry
#http-proxy proxy.swgfl.org.uk 8080

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
if [ -e /opt/magicka/bin ];then
	echo " * magicka directory exists"
else
	echo " * Creating magicka directory"
	mkdir -p /opt/magicka/bin 
fi

echo " * Sorting firewall "
cat << EOF > /opt/magicka/bin/firewall
#!/bin/bash


iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i tun0 -o eth0 -j ACCEPT

EOF
chmod 700 /opt/magicka/bin/firewall
echo " * Running firewall on startup"
cat << EOF > /etc/rc.local
#!/bin/bash

/opt/magicka/bin/firewall

exit 0
EOF
chmod 700 /etc/rc.local

cat << EOF > /etc/sysctl.conf 
net.ipv4.ip_forward=1
EOF

echo " * Now place keys in keys directory and configure /etc/client.conf"

exit 0


