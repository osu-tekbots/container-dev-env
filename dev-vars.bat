::
:: Default MySQL version. The version must also be a valid tag for the 
:: MySQL Docker image.
::
set MYSQL_VERSION=5.5

::
:: Default Docker images to use
::
set MYSQL_IMAGE="mysql:%MYSQL_VERSION%"
set PHP_MY_ADMIN_IMAGE="phpmyadmin/phpmyadmin"
set APACHE_PHP_IMAGE="osu-apache-php"

::
:: Default container names
::
set MYSQL_CONTAINER_NAME="osu-mysql-db"
set PHP_MY_ADMIN_CONTAINER_NAME="osu-mysql-admin"
set APACHE_PHP_CONTAINER_NAME="osu-local-web-server"

::
:: Default Docker bridge network name
::
set NETWORK_NAME="osu-local-dev-net"

::
:: Default port mappings
::
set MYSQL_LOCAL_PORT=3306
set PHP_MY_ADMIN_LOCAL_PORT=5000
set APACHE_PHP_LOCAL_PORT=7000

:: 
:: Allow overwrite of these default values with a local configuration file
::
if exists "%cd%\dev-vars.local.sh" (
    call "%cd%\dev-vars.local.sh"
)