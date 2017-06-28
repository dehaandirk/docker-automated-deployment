#!/bin/sh

sudo apt-get install git
sudo rm -rf /tmp/network
sudo git clone https://github.com/dehaandirk/network/ /tmp/network && cd /tmp/network 
sudo sh nagios.sh
sudo sh docker.sh
sudo sh soltstack.sh



#sudo sh nagios_connect.sh
#sudo sh soltstack_minion.sh
