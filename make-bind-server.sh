#!/bin/bash

CONFIGURED="no"

#The domain name you wish to serve locally
DOMAINNAME="mgka.lan"
#IP Range you want to allow to query the server
TRUSTED="10.0.0.0/8"
#The DNS servers which to forward to (semicolons after each address
FORWARDERS="8.8.8.8;8.8.4.4;"



if [ $CONFIGURED = "no" ];then
	echo " ! You need to edit this file and enter the config for your domain"
	exit 1
fi

echo " * Installing required software"
apt install bind9 -y
apt install net-tools -y

echo " * Creating named.conf.local"
cat << EOF > /etc/bind/named.conf.local
include "/etc/bind/blacklisted.zones";

zone "$DOMAINNAME" {
       type master;
       file "/etc/bind/$DOMAINNAME.zone";
};
EOF

echo " * Creating /etc/bind/named.conf.options"
cat << EOF > /etc/bind/named.conf.options
acl trusted {
        $TRUSTED;
        localhost;
        localnets;
};
options {
        directory "/var/cache/bind";
        //recursion yes;
        allow-query { trusted; };

        auth-nxdomain no;

        forward only;
        forwarders {
                $FORWARDERS
        };

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        dnssec-validation auto;

        //listen-on-v6 { any; };
};
EOF
echo " * Creating primary DNS Zone $DOMAINNAME"
cat << EOF > /etc/bind/$DOMAINNAME.zone
\$TTL    604800
@       IN      SOA     ns.$DOMAINNAME. root.$DOMAINNAME. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.$DOMAINNAME.
ns      IN      A       127.0.0.1
;also list other computers
papercut     IN      A       10.0.1.123
wpad         IN      A       10.0.1.124
EOF

echo " * Creating default blockeddomains.zone"
cat << EOF > /etc/bind/blockeddomains.zone
\$TTL    3600 
@       IN      SOA     ns1.example.local. info.example.local. ( 
                            2014052101         ; Serial 
                                  7200         ; Refresh 
                                   120         ; Retry 
                               2419200         ; Expire 
                                  3600)        ; Default TTL 
; 
@       IN      NS      ns.example.com. 
                A       127.0.0.1 ; This means that naughydomain.com gets directed to the designated address 
*       IN      A       127.0.0.1 ; This wildcard entry means that any permutation of xxx.naughtydomain.com gets directed to the designated address 
                AAAA    ::1 ; This means that naughydomain.com gets directed to IPv6 localhost 
*       IN      AAAA    ::1 ; This wildcard entry means that any permutation of xxx.naughtydomain.com gets directed to IPv6 localhost 
EOF

echo " * Assembling blacklist"
list=$(cat blacklist.raw)

#clear out the zone file
echo "" > /etc/bind/blacklisted.zones

for result in $list 
do
	#rebuild the file
	echo "zone \""$result"\" {type master; file \"/etc/bind/blockeddomains.zone\";};" >> /etc/bind/blacklisted.zones
done

service named stop
service named start
exit 0

