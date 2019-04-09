#!/bin/sh
. './dev-vars.sh'

echo
echo "Starting existing containers"
docker start \
    ${MYSQL_CONTAINER_NAME} \
    ${PHP_MY_ADMIN_CONTAINER_NAME} \
    ${APACHE_PHP_CONTAINER_NAME}

echo
echo "Done"
echo

exit 0