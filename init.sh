#! /bin/sh

sed -i "s/daemonize = yes/daemonize = no/g" /etc/php-fpm.conf
pecl install grpc
pecl install yaf

supervisord