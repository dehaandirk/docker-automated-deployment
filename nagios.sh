#!/bin/bash
	# bron: https://www.howtoforge.com/tutorial/ubuntu-nagios/

# variablen
NAGIOS_VERSION="4.3.2"
NAGIOS_PLUGINGS="2.2.2"
NAGIOS_USERNAME="administrator"
NAGIOS_PASSWORD="admin"

TEMP="/tmp/download"


# Prerequisites
sudo apt-get update
sudo apt-get --yes install wget build-essential apache2 php apache2-mod-php7.0 php-gd libgd-dev sendmail unzip


# User and group configuration
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagios,nagcmd www-data

# Download Nagios

mkdir -p $TEMP
cd $TEMP
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-$NAGIOS_VERSION.tar.gz
tar -xzf nagios-$NAGIOS_VERSION.tar.gz
cd nagios-$NAGIOS_VERSION


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
cd $TEMP
wget https://nagios-plugins.org/download/nagios-plugins-$NAGIOS_PLUGINGS.tar.gz
tar -xzf nagios-plugins-$NAGIOS_PLUGINGS.tar.gz
cd nagios-plugins-$NAGIOS_PLUGINGS/

# Install Plugins
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
sudo make install

# Configure nagios
sudo sh -c 'echo 'cfg_dir=/usr/local/nagios/etc/servers' >> /usr/local/nagios/etc/nagios.cfg'
sudo mkdir -p /usr/local/nagios/etc/servers




sudo sh -c 'echo "[Unit]" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "Description=Nagios" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "BindTo=network.target" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo " " >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "[Install]" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "WantedBy=multi-user.target" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo " " >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "[Service]" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "User=nagios" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "Group=nagios" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "Type=simple" >> /etc/systemd/system/nagios.service'
sudo sh -c 'echo "ExecStart=/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg" >> /etc/systemd/system/nagios.service'
sudo systemctl enable /etc/systemd/system/nagios.service


# Configuring Apache
sudo a2enmod rewrite
sudo a2enmod cgi

sudo htpasswd -bc /usr/local/nagios/etc/htpasswd.users $NAGIOS_USERNAME $NAGIOS_PASSWORD

sudo ln -s /etc/apache2/sites-available/nagios.conf /etc/apache2/sites-enabled/

sudo service apache2 restart
sudo systemctl start nagios

sudo ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios












