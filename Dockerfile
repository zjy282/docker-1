FROM ccr.ccs.tencentyun.com/wind/centos
RUN yum install epel-release -y
RUN yum install nginx -y
CMD ["/sbin/nginx"]