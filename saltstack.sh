#!/bin/bash

sudo add-apt-repository ppa:saltstack/salt
sudo apt-get update
sudo apt-get install --yes salt-master salt-minion salt-ssh salt-cloud salt-doc salt-api salt-syndic


sudo service salt-master start

sudo sed -i '/#master: salt/c\master: 192.168.2.143' /etc/salt/minion

(crontab -l 2>/dev/null; echo "*/5 * * * * sudo salt-key -Ay") | crontab -







# install docker met salt
cd ~
sudo mkdir /srv/salt
sudo cp /tmp/network/top.sls /srv/salt/top.sls
sudo cp /tmp/network/docker.sls /srv/salt/docker.sls
sudo cp /tmp/network/app.sls /srv/salt/app.sls
sudo cp /tmp/network/wordpress.sls /srv/salt/wordpress.sls

sudo salt-call state.highstate  