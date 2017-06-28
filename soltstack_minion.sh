#!/bin/bash

sudo add-apt-repository ppa:saltstack/salt
sudo apt-get update
sudo apt-get install --yes salt-minion

sudo sed -i '/#master: salt/c\master: 192.168.2.143' /etc/salt/minion

sudo service salt-minion restart