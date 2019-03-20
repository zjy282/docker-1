FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
WORKDIR /opt
RUN curl -o /opt/go.tar.gz "https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz" 
RUN tar -zxvf /opt/go.tar.gz && ln -s /opt/go/bin/go* /usr/bin/
COPY ./demo.ini /etc/supervisord.d/demo.ini

EXPOSE 80
EXPOSE 9000
EXPOSE 3306
EXPOSE 6379
EXPOSE 27017

EXPOSE 8080
EXPOSE 8087
EXPOSE 8088