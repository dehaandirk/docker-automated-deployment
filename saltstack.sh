#!/bin/bash

sudo add-apt-repository ppa:saltstack/salt
sudo apt-get update
sudo apt-get install --yes salt-master salt-minion salt-ssh salt-cloud salt-doc salt-api salt-syndic


sudo sed -i '/#master: salt/c\master: 127.0.0.1' /etc/salt/minion

(crontab -l 2>/dev/null; echo "*/5 * * * * sudo salt-key -Ay") | crontab -

sudo service salt-master restart






# install docker met salt
cd ~
sudo mkdir /srv/salt
sudo cp /tmp/network/top.sls /srv/salt/top.sls
sudo cp /tmp/network/docker.sls /srv/salt/docker.sls
sudo cp /tmp/network/app.sls /srv/salt/app.sls
sudo cp /tmp/network/wordpress.sls /srv/salt/wordpress.sls
sudo cp /tmp/network/docker_install.sls /srv/salt/docker_install.sls





#sudo salt-call state.highstate 
#sudo salt-key -L
#sudo salt-key -Ay
#sudo salt '*' test.ping
#sudo salt 'Minion1' state.apply docker_install

 