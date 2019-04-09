call "%cd%\dev-vars.bat"

echo
echo "Stopping containers..."
docker stop ^
    %MYSQL_CONTAINER_NAME% ^
    %PHP_MY_ADMIN_CONTAINER_NAME% ^
    %APACHE_PHP_CONTAINER_NAME%

echo
echo "Done"
echo

exit /b