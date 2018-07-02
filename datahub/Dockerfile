FROM ccr.ccs.tencentyun.com/wind/centos-supervisord
ENV JDKVER java-1.8.0-openjdk.x86_64
RUN yum install $JDKVER -y
RUN echo -e "[program:datahub]\ncommand=java -jar /tmp/datahub/datahub-1.0.jar run ${SHARD_INDEX}\nstdout_logfile=/tmp/datahub/${SHARD_INDEX}.log\nautorestart=true\nstopsignal=KILL" > /etc/supervisord.d/datahub.ini
CMD ["/usr/bin/supervisord"]
