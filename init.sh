#!/bin/sh

if [[ -z $CONF_DIR ]] #配置目录
then
    echo "CONF_DIR is empty"
    echo 'docker ... -e "CONF_DIR=/go/root/src/gitlab.com/x/y/config"'
    exit 1
fi

if [[ ${#GIT_ADDRS[@]} == 0 ]] #项目地址
then
    echo "GIT_ADDRS is empty"
    echo 'docker ... -e "GIT_ADDRS=("https://gitlab.com/x/y.git","https://gitlab.com/x/y-core.git")"'
    exit 2
fi

if [[ -z $MAIN_FILE ]] #入口文件
then
    echo "MAIN_FILE is empty"
    echo 'docker ... -e "MAIN_FILE=/root/go/src/x/y/run/m.go"'
    exit 3
fi

src=$(go env GOPATH)/src

#注入git权限
echo aHR0cHM6Ly9ndWlxaWFuZzoyMDEzMTIyNUBjb2RlLnFzY2hvdS5jb20K | base64 -d > ~/.git-credentials
echo "" >> /etc/hosts && echo "10.27.113.171 code.qschou.com" >> /etc/hosts

for addr in ${GIT_ADDRS[@]}
do
    proDir=$src/$(echo $addr | awk -F "://" '{print $2}' | awk -F '.git' '{print $1}')
    mkdir -p $proDir
    git clone $addr $proDir/
done

go build -o server $src/$MAIN_FILE
source $(go env GOBIN)/server