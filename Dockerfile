FROM ccr.ccs.tencentyun.com/wind/centos

COPY ./init.sh /opt/init.sh
RUN chmod +x /opt/init.sh
CMD ["/opt/init.sh"]