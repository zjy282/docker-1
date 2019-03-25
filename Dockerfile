FROM ccr.ccs.tencentyun.com/wind/centos
RUN yum install epel-release -y
RUN yum install nginx -y
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
CMD ["/sbin/nginx"]