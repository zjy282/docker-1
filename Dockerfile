FROM ccr.ccs.tencentyun.com/wind/centos
RUN yum install openssh-server -y
RUN sshd-keygen
RUN mkdir -p /var/run/sshd
RUN echo "PermitRootLogin without-password" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
CMD ["/usr/sbin/sshd -D"]
