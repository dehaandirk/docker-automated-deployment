#!/bin/sh

sudo apt-get install git
sudo git clone https://github.com/dehaandirk/network/ /tmp/network && cd /tmp/network 
sudo sh nagios.sh
sudo sh docker.sh
