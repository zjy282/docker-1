#! /bin/sh

if [[ ! -d /opt/zkui-master ]]
then
	unzip -q /opt/zkui.zip
fi

if [[ -z $ZKHOST ]]
then
    echo "ZKHOST is empty"
    exit 2
fi

sed -i "s/^zkServer/zkServer=$ZKHOST" /opt/zkui-master/config.cfg

cd /opt/zkui-master
mvn clean install
nohup java -jar zkui-2.0-SNAPSHOT-jar-with-dependencies.jar &

/usr/bin/supervisord
