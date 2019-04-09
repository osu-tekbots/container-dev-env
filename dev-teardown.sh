#!/bin/sh
# Get the defined variable names
. "./dev-vars.sh"

sh './dev-stop.sh'

echo
echo "Removing containers"
docker rm \
    ${MYSQL_CONTAINER_NAME} \
    ${PHP_MY_ADMIN_CONTAINER_NAME} \
    ${APACHE_PHP_CONTAINER_NAME}

echo
echo "Removing bridge network"
docker network rm ${NETWORK_NAME}

echo
echo "Done"
echo