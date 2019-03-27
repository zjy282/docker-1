#! /bin/sh

run() {
    /opt/zookeeper/bin/zkServer.sh start-foreground
}

start() {
    #下载并解压zk安装包
    curl -o /opt/zookeeper.tar.gz "https://www-us.apache.org/dist/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz" > /dev/null
    mkdir /opt/zk
    tar -zxv --directory=/opt/zk -f /opt/zookeeper.tar.gz
    #解压失败退出任务
    [[ $? == 0 ]] || exit 1

    #安装核心组件
    yum install iproute java-1.8.0-openjdk.x86_64 -y > /dev/null

    #创建配置文件
    cp -f $zkDir/conf/zoo_sample.cfg $zkDir/conf/zoo.cfg

    if [[ ${#ZKHOST[@]} == 0 ]]
    then
        echo "ZKHOST is empty"
        echo "docker ... -e 'ZKHOST=10.111.11.249 10.111.11.250 10.111.11.251'"
        exit 2
    fi

    #多网卡模式获取本机ip
    loIps=$(ip -4 addr | grep -o -E "inet ([0-9]+\.){3}[0-9]+" | awk '{print $2}')
    loIp=""
    for ip in ${loIps[@]}
    do
        echo ${ZKHOST[@]} | grep $ip > /dev/null
        if [[ 0 -eq $? ]]
        then
            loIp=$ip
            break
        fi
    done
    if [[ -z $loIp ]]
    then
        echo "local ip is empty"
        exit 2
    fi

    #写入ip和port配置
    j=1
    for i in ${ZKHOST[@]}
    do
        if [[ "$i" == "$local_ip" ]]
        then
            echo "$j" > /tmp/zookeeper/myid
        fi
        
        echo "server.$j=$i:2888:3888" >> $zkDir/conf/zoo.cfg
        j=$[j+1]
    done

    run
}

zkDir=/opt/zk/zookeeper-3.4.13
if [ -d "$zkDir"] 
then
    echo "start"
    start
else
    echo "restart"
    restart
fi