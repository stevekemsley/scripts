#!/bin/bash


echo " * From Ubuntu 18.04 systemd does not run /etc/rc.local on boot"
echo " * This script fixes that"
echo " * "


if [ -e "/etc/rc.local" ];then
	echo " * /etc/rc.local exists leaving alone"
else
	echo " * Creating blank /etc/rc.local"
	cat << EOF > /etc/rc.local
#!/bin/bash

exit 0
EOF
fi

echo " * Making  /etc/rc.local executable"
chmod 700 /etc/rc.local

if [ -e /etc/systemd/system/rc-local.service ];then
	echo " * Service script already installed"
else 
	echo " * Installing service script /etc/systemd/system/rc-local.service"
	echo << EOF > /etc/systemd/system/rc-local.service
[Unit]
 Description=/etc/rc.local Compatibility
 ConditionPathExists=/etc/rc.local

[Service]
 Type=forking
 ExecStart=/etc/rc.local start
 TimeoutSec=0
 StandardOutput=tty
 RemainAfterExit=yes
 SysVStartPriority=99

[Install]
 WantedBy=multi-user.target
EOF


fi

echo " * Activating service script"
systemctl enable rc-local

exit 0

