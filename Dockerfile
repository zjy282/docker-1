FROM ccr.ccs.tencentyun.com/wind/centos

COPY ./init.sh /opt/init.sh
RUN chmod +x /opt/init.sh
RUN yum install -y epel-release ppp pptpd wget unzip
RUN wget "https://github.com/shadowsocks/shadowsocks-go/releases/download/1.2.1/shadowsocks-server.zip" -O /opt/shadowsocks-server.zip

CMD [ "/opt/init.sh" ]