#!/bin/bash

PASSWORD="DItiseensterkW@chtW@ord!!!"
ROOT_PASSWORD="XXX"
DEFAULT_PORT="8081"

mkdir ~/wordpress && cd ~/wordpress


sudo docker pull mariadb
sudo mkdir /opt/wordpress
​sudo mkdir -p /opt/wordpress/database
​sudo mkdir -p /opt/wordpress/html

sudo docker run -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=$PASSWORD -e MYSQL_DATABASE=wordpress_db -v /opt/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb


sudo docker pull wordpress:latest

sudo docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=$PASSWORD -e WORDPRESS_DB_NAME=wordpress_db -p $DEFAULT_PORT:80 -v /opt/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress
