#!/bin/bash

SALT_MASTER_IP="192.168.2.143"

sudo add-apt-repository ppa:saltstack/salt
sudo apt-get update
sudo apt-get install --yes salt-master salt-minion salt-ssh salt-cloud salt-doc salt-api salt-syndic


sudo service salt-master start

sudo sed -i '/#master: salt/c\master: $SALT_MASTER_IP' /etc/salt/minion

(crontab -l 2>/dev/null; echo "*/5 * * * * salt-key -Ay") | crontab -


