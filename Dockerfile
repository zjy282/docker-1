FROM registry.cn-beijing.aliyuncs.com/wind-ali/supervisord
WORKDIR /opt/

COPY ./epel-release.rpm /opt/epel-release.rpm
COPY ./webtatic-release.rpm /opt/webtatic-release.rpm
COPY ./php-fpm.ini /etc/supervisord.d/php-fpm.ini

RUN yum install -y /opt/epel-release.rpm /opt/webtatic-release.rpm
RUN yum install -y gcc.x86_64 gcc-c++.x86_64 make.x86_64 php72w-cli.x86_64 php72w-devel.x86_64 php72w-fpm.x86_64 php72w-gd.x86_64 php72w-mbstring.x86_64 php72w-opcache.x86_64 php72w-pdo.x86_64 php72w-pear.noarch php72w-pecl-redis.x86_64 php72w-xml.x86_64
RUN sed -i "s/daemonize = yes/daemonize = no/g" /etc/php-fpm.conf

CMD ["/usr/bin/supervisord"]