FROM ccr.ccs.tencentyun.com/wind/centos
RUN yum install epel-release -y
RUN yum install supervisor -y
RUN mkdir -p /var/log/supervisor
RUN sed -i "s/nodaemon=false/nodaemon=true/g" /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
