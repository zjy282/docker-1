FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
ENV WORKPATH /opt/
ENV ZKVER zookeeper-3.4.12
ENV JDKVER java-1.8.0-openjdk.x86_64

WORKDIR $WORKPATH

RUN yum install wget -y $JDKVER

RUN wget -q "http://of8hb57or.bkt.clouddn.com/$ZKVER.tar.gz" -O /opt/zookeeper.tar.gz
COPY ./zkInit.sh /opt/zkInit.sh
RUN chmod +x /opt/zkInit.sh

RUN echo -e "[program:zookeeper]\ncommand=/opt/$ZKVER/bin/zkServer.sh" > /etc/supervisord.d/zookeeper.ini
CMD ["/opt/zkInit.sh"]
