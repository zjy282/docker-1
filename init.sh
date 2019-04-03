#!/bin/sh

checkVarEmpty() {
    if [ -z "$CONFIG_DIR" ] #配置目录
    then
        echo "CONFIG_DIR is empty"
        echo 'docker ... -e "CONFIG_DIR=gitlab.com/x/y/config"'
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
}

writeGitPass() {
    #注入git权限
    echo aHR0cHM6Ly9ndWlxaWFuZzoyMDEzMTIyNUBjb2RlLnFzY2hvdS5jb20K | base64 -d >> ~/.git-credentials
}

writeGitHosts() {
    #配置git host
    echo "" >> /etc/hosts
    echo "10.27.113.171 code.qschou.com" >> /etc/hosts
}

cloneCode() {
    #git clone 代码
    for addr in ${GIT_ADDRS[@]}
    do
        proDir=$src/$(echo $addr | awk -F "://" '{print $2}' | awk -F '.git' '{print $1}')
        mkdir -p $proDir > /dev/null
        echo "\$?=$?: mkdir dir $proDir"
        git clone $addr $proDir/ > /dev/null
        echo "\$?=$?: git clone $addr $proDir/"
    done
}

updateCode() {
    for addr in ${GIT_ADDRS[@]}
    do
        proDir=$src/$(echo $addr | awk -F "://" '{print $2}' | awk -F '.git' '{print $1}')
        cd $proDir
        git pull origin master
    done
}

build() {
    #编译
    go build -o $(go env GOBIN)/server $1
    echo "\$?=$?: go build -o $(go env GOBIN)/server $1"
}

run() {
    #执行
    echo "run server ..."
    $(go env GOBIN)/server
}

checkFileExists() {
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
}

start() {
    #设置上海时区
    echo Y | cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

    #检测核心环境变量是否为空
    checkVarEmpty

    #注入git权限
    writeGitPass
    writeGitHosts
    #git clone 代码
    cloneCode
    #检测文件是否存在
    checkFileExists

    #编译
    build $mainFile
    #运行
    run
}

restart() {
    #配置git host
    writeGitHosts
    #获取最新的代码
    updateCode
    #检测文件是否存在
    checkFileExists
    #重新编译
    build $mainFile
    #运行
    run
}

src=$(go env GOPATH)/src
mainFile=$src/$MAIN_FILE
export CONF_DIR=$src/$CONFIG_DIR

if [ -f "$(go env GOBIN)/server" ]
then
    echo "restart"
    restart
else
    echo "start"
    start
fi