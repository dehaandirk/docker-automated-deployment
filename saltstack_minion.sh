#!/bin/bash

SALT_MASTER_IP="192.168.2.143"


sudo add-apt-repository --yes ppa:saltstack/salt 
sudo apt-get update
sudo apt-get install --yes salt-minion

sudo sed -i '/#master: salt/c\master: $SALT_MASTER_IP' /etc/salt/minion

sudo service salt-minion restart