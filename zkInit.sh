#! /bin/sh

if [[ ! -d /opt/$ZKVER ]]
then
    tar -zxf /opt/zookeeper.tar.gz
fi

cp -f /opt/$ZKVER/conf/zoo_sample.cfg /opt/$ZKVER/conf/zoo.cfg
mkdir -p /tmp/zookeeper

if [[ -z $ZKHOST ]]
then
    echo "ZKHOST is empty"
    exit 2
fi

local_ips=$(ip -4 addr | grep -o -E "inet ([0-9]+\.){3}[0-9]+" | awk '{print $2}')
local_ip=""
for i in ${local_ips[@]}
do
    echo $ZKHOST | grep $i > /dev/null
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

j=1
IFS=","
zks=($ZKHOST)
for i in ${zks[@]}
do
    if [[ "$i" == "$local_ip" ]]
    then
        echo "$j" > /tmp/zookeeper/myid
    fi
    
    echo "server.$j=$i:2888:3888" >> /opt/$ZKVER/conf/zoo.cfg
    j=$[j+1]
done

/usr/bin/supervisord
