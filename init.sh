#! /bin/sh

sed -i 's/^#localip/localip/' /etc/pptpd.conf
sed -i 's/^#remoteip/remoteip/' /etc/pptpd.conf
sed -i 's/^#ms-dns/ms-dns/g' /etc/ppp/options.pptpd

touch /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

pass=$RANDOM 
echo "vpn pptpd $pass *" > /etc/ppp/chap-secrets

unzip /opt/shadowsocks-server.zip -d /opt

echo -e "\ncommand=/opt/shadowsocks-server -p 2333 -k $pass -m aes-256-cfb -t 10" >> /etc/supervisord.d/shadow.ini

echo ""
echo "password:$pass"
echo "port:2333"
echo "encryption:aes-256-cfb"
echo ""

pptpd
/usr/bin/supervisord -c /etc/supervisord.conf