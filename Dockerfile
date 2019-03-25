FROM ccr.ccs.tencentyun.com/wind/centos
RUN yum install ansible openssh-clients git -y
RUN mkdir ~/.ssh && chmod 700 ~/.ssh
RUN git config --global credential.helper store