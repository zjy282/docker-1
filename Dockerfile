FROM registry.cn-beijing.aliyuncs.com/wind-ali/supervisord

RUN curl -sL https://rpm.nodesource.com/setup_11.x | bash -
RUN yum install nodejs -y
RUN npm install --global nodaemon