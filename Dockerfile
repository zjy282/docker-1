FROM registry.cn-beijing.aliyuncs.com/wind-ali/supervisord
WORKDIR /opt/

COPY ./epel-release.rpm /opt/epel-release.rpm
COPY ./webtatic-release.rpm /opt/webtatic-release.rpm
COPY ./init.sh /opt/init.sh
COPY ./php-fpm.ini /etc/supervisord.d/php-fpm.ini
RUN chmod +x /opt/init.sh

CMD ["/opt/init.sh"]