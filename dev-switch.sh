#!/bin/sh
#
# This script will switch the the osu-local-web-server to use a different public/private
# host directory, effectively allowing us to easily switch between working on different
# websites.
#

if [ $# -ne 2 ]; then
    echo
    echo "usage: sh dev-switch.sh <local_public_files> <local_private_files>"
    echo
    echo "    <local_public_files> is the new local directory of the public files to be served by the"
    echo "        web server (PHP, HTML, CSS, etc.)"
    echo
    echo "    <local_private_basepath> is the new local directory of the private files (database config,"
    echo "        logs, etc.) used for website configuration and data storage"
    echo
    exit 1
fi

PUBLIC_CONTENT="$1"
PRIVATE_CONTENT="$2"

. './dev-vars.sh'

echo
echo "Stopping old web server"
docker stop ${APACHE_PHP_CONTAINER_NAME}

echo
echo "Removing old web server"
docker rm ${APACHE_PHP_CONTAINER_NAME}

echo
echo "Starting new web server"
docker run -d --name ${APACHE_PHP_CONTAINER_NAME} \
    --network ${NETWORK_NAME} \
    -p ${APACHE_PHP_LOCAL_PORT}:80 \
    -v ${PUBLIC_CONTENT}:/var/www/html \
    -v ${PRIVATE_CONTENT}:/var/www \
    ${APACHE_PHP_IMAGE}

echo
echo "Done"
echo

exit 0
