#!/bin/bash

wget https://www.mgka.net/www/orgs/magicka.co.uk/software/senagent_linux_amd64
wget https://www.mgka.net/www/orgs/magicka.co.uk/software/senupdater_linux_amd64

chnod 700 sen*
mv sen* /usr/bin

exit 0



