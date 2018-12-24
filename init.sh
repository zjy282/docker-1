#! /bin/sh

rpm -Uvh /opt/epel-release.rpm
rpm -Uvh /opt/webstatic-release.rpm

yum install -y gcc.x86_64 gcc-c++.x86_64 make.x86_64 php72w-cli.x86_64 php72w-devel.x86_64 php72w-fpm.x86_64 php72w-gd.x86_64 php72w-mbstring.x86_64 php72w-opcache.x86_64 php72w-pdo.x86_64 php72w-pear.noarch php72w-pecl-redis.x86_64 php72w-pecl-xdebug.x86_64 php72w-xml.x86_64

sed -i "s/daemonize = yes/daemonize = no/g" /etc/php-fpm.conf

/usr/bin/supervisord -c /etc/supervisord.conf