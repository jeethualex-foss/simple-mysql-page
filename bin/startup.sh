httpd -v
php -v
php -m
echo Starting PHP FRM...
php-fpm -D
echo Starting Apache...
httpd -D FOREGROUND