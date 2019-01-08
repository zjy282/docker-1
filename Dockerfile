FROM registry.cn-beijing.aliyuncs.com/wind-ali/supervisord

COPY ./init.sh /opt/init.sh
COPY ./shadow.ini /etc/supervisord.d/shadow.ini
RUN chmod +x /opt/init.sh
RUN yum install -y epel-release ppp pptpd golang
RUN go get github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-server

CMD [ "/opt/init.sh" ]