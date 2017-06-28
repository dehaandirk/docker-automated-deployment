#!/bin/sh

sudo apt-get install git
sudo git clone https://github.com/dehaandirk/network/ /tmp/netwerk && cd /tmp/network && sh nagios.sh
