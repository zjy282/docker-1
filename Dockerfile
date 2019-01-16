FROM registry.cn-beijing.aliyuncs.com/wind-ali/supervisord

RUN curl -sL https://rpm.nodesource.com/setup_11.x | bash -
RUN yum install nodejs -y
RUN npm install --global nodemon
COPY ./nodemon.json /etc/nodemon.json
RUN echo 'alias nodemon="nodemon --config /etc/nodemon.json"' >> /etc/bashrc

EXPOSE 80
EXPOSE 9000
EXPOSE 3306
EXPOSE 6379
EXPOSE 27017

EXPOSE 8080
EXPOSE 8087
EXPOSE 8088