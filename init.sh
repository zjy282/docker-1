#! /bin/sh

sed -i 's/^#localip/localip/' /etc/pptpd.conf
sed -i 's/^#remoteip/remoteip/' /etc/pptpd.conf
sed -i 's/^#ms-dns/ms-dns/g' /etc/ppp/options.pptpd

touch /etc/sysctl.conf
sed -i 'anet.ipv4.ip_forward=1' /etc/sysctl.conf
sysctl -p

pass=$RANDOM 
sed -i "avpn pptpd $RANDOM *" /etc/ppp/chap-secrets

/etc/init.d/pptpd start
chkconfig pptpd on

unzip /opt/shadowsocks-server.zip -d /opt

sed -i "acommand=/opt/shadowsocks-server -p 2333 -k $pass -m aes-256-cfb -t 10" /etc/supervisord.d/shadow.ini

echo "password:$pass\n"
echo "port:2333\n"
echo "encryption:aes-256-cfb\n"

/usr/bin/supervisord