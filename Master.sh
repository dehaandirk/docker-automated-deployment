#!/bin/sh

sudo apt-get install git
sudo apt-get install openssh-server 

sudo rm -rf /tmp/network
sudo git clone https://github.com/dehaandirk/network/ /tmp/network && cd /tmp/network 
sudo sh nagios.sh
sudo sh docker.sh
sudo sh saltstack.sh




#sudo sh nagios_connect.sh
#sudo sh saltstack_minion.sh





#sudo salt-call state.highstate 
#sudo salt-key -L
#sudo salt-key -Ay
#sudo salt '*' test.ping
#sudo salt 'Minion1' state.apply docker_install