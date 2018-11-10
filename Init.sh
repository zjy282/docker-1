#! /bin/sh

if [[ -z $HOST ]]
then
    echo "HOST is empty"
    exit 2
fi

local_ips=$(ip -4 addr | grep -o -E "inet ([0-9]+\.){3}[0-9]+" | awk '{print $2}')
local_ip=""
for i in ${local_ips[@]}
do
    echo $HOST | grep $i > /dev/null
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

m=$[$(cat /proc/meminfo |grep 'MemTotal' |awk '{print $2}')/2048]
sed -i "s/^-Xms1g/-Xms${m}m/g" /etc/elasticsearch/jvm.options
sed -i "s/^-Xmx1g/-Xmx${m}m/g" /etc/elasticsearch/jvm.options

echo "cluster.name: my-application" >> /etc/elasticsearch/elasticsearch.yml
echo "bootstrap.memory_lock: true" >> /etc/elasticsearch/elasticsearch.yml
echo "network.host: $local_ip" >> /etc/elasticsearch/elasticsearch.yml
echo "http.port: 9200" >> /etc/elasticsearch/elasticsearch.yml
echo "transport.tcp.port: 9300" >> /etc/elasticsearch/elasticsearch.yml
echo "discovery.zen.ping.unicast.hosts: [${HOST}]" >> /etc/elasticsearch/elasticsearch.yml

/usr/bin/supervisord
