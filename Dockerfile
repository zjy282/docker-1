FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
ENV WORKPATH /opt/
ENV KFKVER kafka_2.12-1.1.0
ENV JDKVER java-1.8.0-openjdk.x86_64

WORKDIR $WORKPATH

RUN yum install wget iproute $JDKVER -y

RUN wget -q "http://of8hb57or.bkt.clouddn.com/$KFKVER.tgz" -O /opt/kfk.tgz
COPY ./kfkInit.sh /opt/kfkInit.sh
COPY ./kfk.ini /etc/supervisord.d/kfk.ini
RUN chmod +x /opt/kfkInit.sh
RUN ln -s /opt/$KFKVER kafka

CMD ["/opt/kfkInit.sh"]
