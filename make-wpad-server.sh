#!/bin/bash

CONFIGURED="no"

#The domain name you wish to serve locally
DOMAINNAME="mgka.lan"
#IP Range you want to allow to query the server
TRUSTED="10.0.0.0/8"
#The DNS servers which to forward to (semicolons after each address
FORWARDERS="8.8.8.8;8.8.4.4;"


echo " * Getting gohttp"
rm /usr/bin/gohttp &> /dev/null
wget http://remote.magicka.co.uk/gohttp -O /usr/bin/gohttp
echo " * Making wpad dir"
mkdir /var/lib/tftpboot/www/wpad -p
echo " * Making default wpad.dat"
cat << EOF > /var/lib/tftpboot/www/wpad/wpad.dat


EOF


exit 0

