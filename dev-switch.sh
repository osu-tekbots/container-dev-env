#!/bin/sh
#
# This script will switch the the osu-local-web-server to use a different public/private
# host directory, effectively allowing us to easily switch between working on different
# websites.
#

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo
    echo "usage: sh dev-switch.sh <local_public_files> [<local_private_files>]"
    echo
    echo "    <local_public_files> is the new local directory of the public files to be served by the"
    echo "        web server (PHP, HTML, CSS, etc.)"
    echo
    echo "    <local_private_files> is the optional new local directory of the private files (database"
    echo "        config, logs, etc.) used for website configuration and data storage. The old version will"
    echo "        *not* be used if no path is given"
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
if [ -z "${PRIVATE_CONTENT}" ]; then
    # No private volume to link
    docker run -d --name ${APACHE_PHP_CONTAINER_NAME} \
        --network ${NETWORK_NAME} \
        -p ${APACHE_PHP_LOCAL_PORT}:80 \
        -v "${PUBLIC_CONTENT}":/var/www/html \
        ${APACHE_PHP_IMAGE}
else
    # Link private volume in addition to public volume
    docker run -d --name ${APACHE_PHP_CONTAINER_NAME} \
        --network ${NETWORK_NAME} \
        -p ${APACHE_PHP_LOCAL_PORT}:80 \
        -v "${PUBLIC_CONTENT}":/var/www/html \
        -v "${PRIVATE_CONTENT}":/var/www \
        ${APACHE_PHP_IMAGE}
fi

echo
echo "Done"
echo

exit 0
