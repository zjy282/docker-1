FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
RUN yum install openssh-server -y
RUN sshd-keygen
RUN mkdir -p /var/run/sshd
RUN echo -e "[program:sshd]\ncommand=/usr/sbin/sshd -D" > /etc/supervisord.d/sshd.ini
RUN echo "PermitRootLogin without-password" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN sed -i "s/^PasswordAuthentication/#PasswordAuthentication/g" /etc/ssh/sshd_config
ADD ssh.tar /root/
CMD ["/usr/bin/supervisord"]
