FROM ccr.ccs.tencentyun.com/wind/go

WORKDIR /opt
COPY ./init.sh /opt/init.sh
RUN chmod +x /opt/init.sh

CMD ["/opt/init.sh"]