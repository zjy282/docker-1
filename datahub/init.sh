#! /bin/sh

echo -e "[program:datahub]\ncommand=java -jar /tmp/datahub/datahub-1.0.jar run ${SHARD_INDEX}\nstdout_logfile=/tmp/datahub/${SHARD_INDEX}.log\nautorestart=true\nstopsignal=KILL" > /etc/supervisord.d/datahub.ini

/usr/bin/supervisord
