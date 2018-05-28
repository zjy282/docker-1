#! /bin/sh

if [[ ! -d /opt/$ZKVER ]]
then
    tar -zxf /opt/zookeeper.tar.gz
fi

cp -f /opt/$ZKVER/conf/zoo_sample.cfg /opt/$ZKVER/conf/zoo.cfg
mkdir -p /tmp/zookeeper

if [[ -z $ZKID ]]
then
    echo "ZKID is empty"
    exit 2
fi

if [[ -z $ZKHOST ]]
then
    echo "ZKHOST is empty"
    exit 2
fi

echo "$ZKID" > /tmp/zookeeper/myid

j=1
IFS=","
zks=($ZKHOST)
for i in ${zks[@]}
do
    echo "server.$j=$i:2888:3888" >> /opt/$ZKVER/conf/zoo.cfg
    j=$[j+1]
done

/usr/bin/supervisord
