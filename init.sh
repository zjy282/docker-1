#!/bin/sh

if [ -z "$CONF_DIR" ] #配置目录
then
    echo "CONF_DIR is empty"
    echo 'docker ... -e "CONF_DIR=gitlab.com/x/y/config"'
    exit 1
fi

if [[ ${#GIT_ADDRS[@]} == 0 ]] #项目地址
then
    echo "GIT_ADDRS is empty"
    echo 'docker ... -e "GIT_ADDRS=("https://gitlab.com/x/y.git" "https://gitlab.com/x/y-core.git")"'
    exit 2
fi

if [ -z "$MAIN_FILE" ] #入口文件
then
    echo "MAIN_FILE is empty"
    echo 'docker ... -e "MAIN_FILE=gitlab.com/x/y/run/m.go"'
    exit 3
fi

src=$(go env GOPATH)/src
export CONF_DIR=$src/$CONF_DIR
mainFile=$src/$MAIN_FILE

#注入git权限
echo aHR0cHM6Ly9ndWlxaWFuZzoyMDEzMTIyNUBjb2RlLnFzY2hvdS5jb20K | base64 -d > ~/.git-credentials
echo "" >> /etc/hosts && echo "10.27.113.171 code.qschou.com" >> /etc/hosts

#clone 代码
for addr in ${GIT_ADDRS[@]}
do
    proDir=$src/$(echo $addr | awk -F "://" '{print $2}' | awk -F '.git' '{print $1}')
    mkdir -p $proDir
    git clone $addr $proDir/
done

#检测配置目录是否存在
if [ ! -d "$CONF_DIR" ]
then
    echo "CONF_DIR:$CONF_DIR dir is not found"
    exit 4
fi

#检测入口文件是否存在
if [ ! -f "$mainFile" ]
then
    echo "MAIN_FILE:$mainFile file is not found"
    exit 5
fi

#编译
go build -o $(go env GOBIN)/server $mainFile
#执行
$(go env GOBIN)/server