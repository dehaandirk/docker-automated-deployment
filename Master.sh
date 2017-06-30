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
