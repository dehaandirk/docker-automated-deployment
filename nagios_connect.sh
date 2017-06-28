#!/bin/bash
	# bron: https://www.howtoforge.com/tutorial/ubuntu-nagios/
	
	
	
NAGIOS_SERVER="192.168.2.143"
	
sudo apt-get --yes install nagios-nrpe-server nagios-plugins
sudo sh -c 'echo 'server_address=$NAGIOS_SERVER' >> /etc/nagios/nrpe.cfg'
service nagios-nrpe-server restart