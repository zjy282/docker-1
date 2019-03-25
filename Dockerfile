FROM ccr.ccs.tencentyun.com/wind/centos
RUN yum install ansible openssh-clients -y
RUN mkdir ~/.ssh && chmod 700 ~/.ssh