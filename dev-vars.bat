::
:: Default Docker images to use
::
set MYSQL_IMAGE="mariadb:10.3"
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
if exist "%cd%\dev-vars.local.sh" (
    call "%cd%\dev-vars.local.sh"
)