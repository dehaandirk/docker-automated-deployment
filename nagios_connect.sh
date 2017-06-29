#!/bin/bash
	# bron: https://www.howtoforge.com/tutorial/ubuntu-nagios/
	
	
# variablen
NAGIOS_SERVER="192.168.2.143"

#install & connect	
sudo apt-get --yes install nagios-nrpe-server nagios-plugins
sudo sed -i '/#server_address=127.0.0.1/c\server_address=$NAGIOS_SERVER' /etc/nagios/nrpe.cfg
service nagios-nrpe-server restart