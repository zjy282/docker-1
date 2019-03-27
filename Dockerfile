FROM ccr.ccs.tencentyun.com/wind/centos

COPY ./inti.sh /opt/init.sh
CMD ["source" "/opt/init.sh"]