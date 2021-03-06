#!/bin/bash

CONFIGURED="no"

#The domain name you wish to serve locally
DOMAINNAME="mgka.lan"


echo " * Getting gohttp"
rm /usr/bin/gohttp &> /dev/null
wget http://remote.magicka.co.uk/gohttp -O /usr/bin/gohttp
echo " * Making wpad dir"
mkdir /var/lib/tftpboot/www/wpad -p
echo " * Making default wpad.dat"
cat << EOF > /var/lib/tftpboot/www/wpad/default.dat
function FindProxyForURL(url, host) {
        if(isPlainHostName(host)) {
                return "DIRECT"
        }
        var resolved_ip = dnsResolve(host);

        if (isInNet(resolved_ip, "10.0.0.0", "255.0.0.0") ||
            isInNet(resolved_ip, "172.16.0.0",  "255.240.0.0") ||
            isInNet(resolved_ip, "192.168.0.0", "255.255.0.0") ||
            isInNet(resolved_ip, "127.0.0.0", "255.255.255.0"))
            return "DIRECT";
        
	if (localHostOrDomainIs("$DOMAINNAME")) {
                return "DIRECT";
        }

        return "PROXY proxy.swgfl.org.uk:8080";

}
EOF
echo " * Making staff staff.dat"
cat << EOF > /var/lib/tftpboot/www/wpad/staff.dat
function FindProxyForURL(url, host) {
        if(isPlainHostName(host)) {
                return "DIRECT"
        }
        var resolved_ip = dnsResolve(host);

        if (isInNet(resolved_ip, "10.0.0.0", "255.0.0.0") ||
            isInNet(resolved_ip, "172.16.0.0",  "255.240.0.0") ||
            isInNet(resolved_ip, "192.168.0.0", "255.255.0.0") ||
            isInNet(resolved_ip, "127.0.0.0", "255.255.255.0"))
            return "DIRECT";

	if (localHostOrDomainIs("$DOMAINNAME")) {
                return "DIRECT";
        }

        return "PROXY nossl.proxy1.rmsafetynet.com:8080";
}
EOF

exit 0

