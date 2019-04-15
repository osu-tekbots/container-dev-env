#!/bin/sh

#
# Default Docker images to use
#
MYSQL_IMAGE="mariadb:10.3"
PHP_MY_ADMIN_IMAGE='phpmyadmin/phpmyadmin'
APACHE_PHP_IMAGE='osu-apache-php'

#
# Default container names
#
MYSQL_CONTAINER_NAME='osu-mysql-db'
PHP_MY_ADMIN_CONTAINER_NAME='osu-mysql-admin'
APACHE_PHP_CONTAINER_NAME='osu-local-web-server'

#
# Default Docker bridge network name
#
NETWORK_NAME='osu-local-dev-net'

#
# Default port mappings
#
MYSQL_LOCAL_PORT=3306
PHP_MY_ADMIN_LOCAL_PORT=5000
APACHE_PHP_LOCAL_PORT=7000

# 
# Allow overwrite of these default values with a local configuration file
#
if [ -f './dev-vars.local.sh' ]; then
    . './dev-vars.local.sh'
fi