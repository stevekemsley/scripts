#!/bin/bash

wget https://www.mgka.net/www/orgs/magicka.co.uk/software/senagent/senagent_linux_amd64
wget https://www.mgka.net/www/orgs/magicka.co.uk/software/senagent/senupdater_linux_amd64

chmod 700 sen*
mv sen* /usr/bin

exit 0



