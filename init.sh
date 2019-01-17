#! /bin/sh

sed -i "s/daemonize = yes/daemonize = no/g" /etc/php-fpm.conf

function yaf() {
    pecl install yaf
    echo "extension=yaf.so" >> /etc/php.d/yaf.ini
    echo "yaf.cache_config=1" >> /etc/php.d/yaf.ini
    echo "yaf.use_namespace=1" >> /etc/php.d/yaf.ini
    if [[ -z "${YAF_ENV}" ]] 
    then
        echo -e "\nyaf.environ=\"development\"" >> /etc/php.d/yaf.ini
    else
        echo -e "\nyaf.environ=\"${YAF_ENV}\"" >> /etc/php.d/yaf.ini
    fi
}

function grpc() {
    pecl install grpc
    echo "extension=grpc.so" >> /etc/php.d/grpc.ini
}

if [[ ${#MODULES[@]} -gt 0 ]]
then
    for module in ${MODULES[@]}
    do
        if [ "$(type -t $module)" = "function" ]
        then
            $module
        fi;
    done
fi

supervisord