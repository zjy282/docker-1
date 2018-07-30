FROM ccr.ccs.tencentyun.com/wind/centos-supervisord 

RUN yum install unzip wget maven java-1.8.0-openjdk -y
RUN wget -q https://codeload.github.com/DeemOpen/zkui/zip/master -O /opt/zkui.zip && unzip -q /opt/zkui.zip -d /opt

WORKDIR /opt/zkui-master

RUN mvn clean install
COPY ./zkui_init.sh /opt/zkui_init.sh
RUN chmod +x /opt/zkui_init.sh
CMD ["/opt/zkui_init.sh"]
