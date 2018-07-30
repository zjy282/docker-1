#! /bin/sh

if [[ -z $ZKHOST ]]
then
    echo "ZKHOST is empty"
    exit 2
fi

sed -i "s/^zkServer/zkServer=$ZKHOST" /opt/zkui-master/config.cfg

nohup java -jar zkui-2.0-SNAPSHOT-jar-with-dependencies.jar &

/usr/bin/supervisord
