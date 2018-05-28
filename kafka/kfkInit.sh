#! /bin/sh

if [[ ! -d /opt/$KFKVER ]]
then
    tar -zxf /opt/kfk.tgz
fi

if [[ -z $ZKHOST ]]
then
    echo "ZKHOST is empty"
    exit 2
fi

sed -i "s/^broker.id=0/broker.id=-1/g" /opt/kafka/config/server.properties

echo "zookeeper.connect=$ZKHOST" >> /opt/kafka/config/server.properties
echo "producer.type=async" >> /opt/kafka/config/server.properties
echo "request.required.acks=1" >> /opt/kafka/config/server.properties
echo "queue.buffering.max.ms=100" >> /opt/kafka/config/server.properties
echo "compression.codec=gzip" >> /opt/kafka/config/server.properties

sed -i "1a\export JMX_PORT=9999" /opt/kafka/bin/kafka-server-start.sh

/usr/bin/supervisord
