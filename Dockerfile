FROM ccr.ccs.tencentyun.com/wind/centos

COPY ./init.sh /opt/init.sh
CMD ["source" "/opt/init.sh"]