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

if [[ -z $KFKHOST ]]
then
    echo "KFKHOST is empty"
    exit 2
fi

local_ips=$(ip -4 addr | grep -o -E "inet ([0-9]+\.){3}[0-9]+" | awk '{print $2}')
local_ip=""
for i in ${local_ips[@]}
do
    echo $KFKHOST | grep $i > /dev/null
    if [[ 0 -eq $? ]]
    then
        local_ip=$i
        break
    fi
done

if [[ -z $local_ip ]]
then
    echo "local_ip is empty"
    exit 2
fi

partition_count=$[$(echo "$KFKHOST" | grep -o "," | wc -l)+1]

sed -i "s/^broker.id=0/broker.id=-1/g" /opt/kafka/config/server.properties
sed -i "s/^num.partitions=1/num.partitions=$partition_count/g" /opt/kafka/config/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$ZKHOST/g" /opt/kafka/config/server.properties

echo "" >> /opt/kafka/config/server.properties
echo "listeners=PLAINTEXT://$local_ip:9092" >> /opt/kafka/config/server.properties
echo "producer.type=async" >> /opt/kafka/config/server.properties
echo "request.required.acks=1" >> /opt/kafka/config/server.properties
echo "queue.buffering.max.ms=100" >> /opt/kafka/config/server.properties
echo "compression.codec=gzip" >> /opt/kafka/config/server.properties

sed -i "1a\export JMX_PORT=9999" /opt/kafka/bin/kafka-server-start.sh

/usr/bin/supervisord
