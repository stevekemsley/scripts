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
apt install isc-dhcp-server

echo " * Creating /etc/dhcp/dhcpd.conf"
cat << EOF > /etc/dhcp/dhcpd.conf
uthoritative;
default-lease-time              21600;
max-lease-time                  21600;
use-host-decl-names             on;
ddns-update-style               none;

allow booting;
allow bootp;
filename "/pxelinux.0";

option option-176 code 176 = string;
option option-150 code 150 = text;
#Neuter Windows 7 DHCPINFORM messages
option wpad code 252 = text;


##############################################################################################
## Enable Static routes                                                                      #
##############################################################################################
option rfc3442-classless-static-routes code 121 = array of integer 8;
option ms-classless-static-routes code 249 = array of integer 8;

##############################################################################################


host host1 { hardware ethernet 00:16:3e:7d:66:09 ; fixed-address 10.0.1.5; }

shared-network magicka {
        subnet 10.0.1.0 netmask 255.255.255.0 {

                # Add 192.168.114.0/24 and 10.0.0.0/8 via 10.0.1.29, and 0.0.0.0 via 10.0.1.254
                option rfc3442-classless-static-routes
                        24,     192, 168, 114,  10, 0, 1, 28,
                        8,      10,             10, 0, 1, 28,
                        0,      10, 0, 1, 254;
                option ms-classless-static-routes
                        24,     192, 168, 114,  10, 0, 1, 28,
                        8,      10,             10, 0, 1, 28,
                        0,                      10, 0, 1, 254;

                #Neuter Windows 7 DHCPINFORM messages
                option wpad = "\n";
                #option wpad = "http://10.0.1.60/wpad.dat";
                option routers 10.0.1.254;
                option domain-name-servers      10.0.1.60,8.8.4.4;
                option domain-name "$DOMAINNAME";
                option broadcast-address 10.0.1.255;
                range 10.0.1.100 10.0.1.200;
                option option-150 "/epia/boot/grub.1st";
                next-server 10.0.1.3;
                filename "/pxelinux.0";
        }
}

EOF
exit 0

