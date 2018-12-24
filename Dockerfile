FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
ENV WORKPATH /opt/
ENV KFKVER kafka_2.12-2.0.1
ENV JDKVER java-1.8.0-openjdk.x86_64

WORKDIR $WORKPATH

RUN yum install wget iproute $JDKVER -y

RUN wget -q "http://mirror.bit.edu.cn/apache/kafka/2.0.1/$KFKVER.tgz" -O /opt/kfk.tgz
COPY ./kfkInit.sh /opt/kfkInit.sh
COPY ./kfk.ini /etc/supervisord.d/kfk.ini
RUN chmod +x /opt/kfkInit.sh
RUN ln -s /opt/$KFKVER kafka

CMD ["/opt/kfkInit.sh"]
