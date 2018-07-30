#! /bin/sh

if [[ -z $ZKHOST ]]
then
    echo "ZKHOST is empty"
    exit 2
fi

sed -i "s/^zkServer/zkServer=$ZKHOST/g" /opt/zkui-master/config.cfg

/usr/bin/supervisord
