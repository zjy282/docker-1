FROM ccr.ccs.tencentyun.com/wind/centos-sshd
RUN yum install redis -y
RUN echo -e "[program:redis]\ncommand=/usr/bin/redis-server" > /etc/supervisord.d/redis.ini
CMD ["/usr/bin/supervisord"]
