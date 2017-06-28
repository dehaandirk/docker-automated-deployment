#!/bin/bash

# Prerequisites
sudo apt-get update
sudo apt-get --yes install wget build-essential apache2 php apache2-mod-php7.0 php-gd libgd-dev sendmail unzip


# User and group configuration
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagios,nagcmd www-data

# Download Nagios

wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.2.0.tar.gz
tar -xzf nagios*.tar.gz
cd nagios-4.2.0


# Compile & install nagios
./configure --with-nagios-group=nagios --with-command-group=nagcmd

make all
sudo make install
sudo make install-commandmode
sudo make install-init
sudo make install-config
sudo /usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-available/nagios.conf

sudo cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
sudo chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers

# download Plugins
cd ~
wget https://nagios-plugins.org/download/nagios-plugins-2.1.2.tar.gz
tar -xzf nagios-plugins*.tar.gz
cd nagios-plugins-2.1.2/

# Install Plugins
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
sudo make install

# Configure nagios
sudo sh -c 'echo 'cfg_dir=/usr/local/nagios/etc/servers' >> /usr/local/nagios/etc/nagios.cfg'
sudo mkdir -p /usr/local/nagios/etc/servers


# Configuring Apache
sudo a2enmod rewrite
sudo a2enmod cgi

printf "%s %s\n" "Please enter a password for the Nagios web administration user:" administrator
sudo htpasswd -c -b /usr/local/nagios/etc/htpasswd.users administrator admin

sudo ln -s /etc/apache2/sites-available/nagios.conf /etc/apache2/sites-enabled/


sudo service apache2 restart
sudo service nagios start

sudo ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios












