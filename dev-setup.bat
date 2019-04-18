if "%1%" == ""
if "%2%" == "" (
    echo
    echo "usage: dev-setup.bat <local_public_files> <local_private_files>"
    echo
    echo "    <local_public_files> is the local directory of the public files to be served by the"
    echo "        web server (PHP, HTML, CSS, etc.)"
    echo
    echo "    <local_private_basepath> is the local directory of the private files (database config,"
    echo "        logs, etc.) used for website configuration and data storage"
    echo
    exit /b
)

DB_PASSWORD=""

:passwordloop
echo @off
set /p DB_PASSWORD="Enter DB Password: "
echo @on
echo
if "%DB_PASSWORD%" == "" goto passwordloop

set /p DB_NAME="Enter name for default database [osulocaldev]: "
if "%DB_NAME%" == "" set DB_NAME="osulocaldev"

set PUBLIC_CONTENT="%1%"
set PRIVATE_CONTENT="%2%"

:: Get the defined variable names
call "%cd%\dev-vars.bat"

echo
echo "Creating bridge network for development containers..."
docker network create --driver bridge %NETWORK_NAME%

echo
echo "Creating and starting MySQL server container..."
docker run -d --name %MYSQL_CONTAINER_NAME% ^
    --network %NETWORK_NAME% ^
    -e MYSQL_ROOT_PASSWORD="%DB_PASSWORD%" ^
    -e MYSQL_DATABASE="%DB_NAME%" ^
    -p %MYSQL_LOCAL_PORT%:3306 ^
    %MYSQL_IMAGE%

echo
echo "Creating and starting phpMyAdmin container..."
docker run -d --name %PHP_MY_ADMIN_CONTAINER_NAME% ^
    --network %NETWORK_NAME% ^
    --link %MYSQL_CONTAINER_NAME%:db ^
    -p %PHP_MY_ADMIN_LOCAL_PORT%:80 ^
    %PHP_MY_ADMIN_IMAGE%

echo
echo "Building and starting custom Apache PHP server for OSU website development..."
docker build . -t %APACHE_PHP_IMAGE%

docker run -d --name %APACHE_PHP_CONTAINER_NAME% ^
    --network %NETWORK_NAME% ^
    -p %APACHE_PHP_LOCAL_PORT%:80 ^
    -v %PUBLIC_CONTENT%:/var/www/html ^
    -v %PRIVATE_CONTENT%:/var/www ^
    %APACHE_PHP_IMAGE%

echo
echo "Local OSU website development environment setup complete."
echo "3 docker containers were started:"
echo "    - %MYSQL_CONTAINER_NAME%"
echo "    - %PHP_MY_ADMIN_CONTAINER_NAME%"
echo "    - %APACHE_PHP_CONTAINER_NAME%"
echo
echo "All containers are part of the %NETWORK_NAME% docker bridge network."
echo
echo "The script has created a MySQL database server with the following credentials:"
echo "    host: %MYSQL_CONTAINER_NAME%"
echo "    user: root"
echo "    pass: %DB_PASSWORD%"
echo "    name: %DB_NAME%"
echo
echo "phpMyAdmin is available at http://localhost:%PHP_MY_ADMIN_LOCAL_PORT%"
echo
echo "The Apache PHP server serving content for the website is listening at"
echo "http://localhost:%APACHE_PHP_LOCAL_PORT%"
echo

pause

exit /b
