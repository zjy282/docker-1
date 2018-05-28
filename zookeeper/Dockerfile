FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
ENV WORKPATH /opt/
ENV ZKVER zookeeper-3.4.12
ENV JDKVER java-1.8.0-openjdk.x86_64

WORKDIR $WORKPATH

ADD http://of8hb57or.bkt.clouddn.com/$ZKVER.tar.gz .
COPY ./zkInit.sh /opt/$ZKVER/bin/zkInit.sh

RUN yum install -y $JDKVER
RUN echo -e "[program:zookeeper]\ncommand=/opt/$ZKVER/bin/zkInit.sh" > /etc/supervisord.d/zookeeper.ini
CMD ["/usr/bin/supervisord"]
