FROM ccr.ccs.tencentyun.com/wind/centos
RUN yum install epel-release nginx -y
CMD ["/usr/bin/nginx"]