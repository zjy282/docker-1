FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
ENV WORKPATH /opt/
ENV JDKVER java-1.8.0-openjdk.x86_64
RUN yum install $JDKVER -y
COPY .init.sh /opt/init.sh
RUN chmod +x /opt/init.sh
CMD ["/opt/init.sh"]
