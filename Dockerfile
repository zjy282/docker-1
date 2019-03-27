FROM ccr.ccs.tencentyun.com/wind/centos

COPY ./init.sh /opt/init.sh
CMD ["/bin/sh" "/opt/init.sh"]