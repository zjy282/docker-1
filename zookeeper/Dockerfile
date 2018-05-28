FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
ENV WORKPATH /opt/
ENV ZKVER zookeeper-3.4.12
ENV JDKVER java-1.8.0-openjdk.x86_64

WORKDIR $WORKPATH

RUN yum install wget -y $JDKVER

RUN wget -q "http://of8hb57or.bkt.clouddn.com/$ZKVER.tar.gz" -O /opt/zookeeper.tar.gz
COPY ./zkInit.sh /opt/zkInit.sh
COPY ./zookeeper.ini /etc/supervisord.d/zookeeper.ini
RUN chmod +x /opt/zkInit.sh
RUN ln -s /opt/$ZKVER/bin/zkServer.sh /opt/zkServer.sh

CMD ["/opt/zkInit.sh"]
