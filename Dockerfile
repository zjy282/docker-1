FROM registry.cn-qingdao.aliyuncs.com/wind-ali/centos-supervisord
ENV WORKPATH /opt/
ENV PROVER elasticsearch-6.4.3
ENV JDKVER java-1.8.0-openjdk.x86_64

RUN yum install wget iproute $JDKVER -y

RUN wget -q "https://artifacts.elastic.co/downloads/elasticsearch/$PROVER.rpm" -O /opt/es.rpm
RUN yum install /opt/es.rpm -y
COPY ./Init.sh /opt/Init.sh
COPY ./es.ini /etc/supervisord.d/es.ini
RUN chmod +x /opt/Init.sh

WORKDIR $WORKPATH

CMD ["/opt/Init.sh"]
