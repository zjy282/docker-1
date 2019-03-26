FROM ccr.ccs.tencentyun.com/wind/centos
WORKDIR /opt
RUN curl -o /opt/go.tar.gz "https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz" 
RUN tar -zxvf /opt/go.tar.gz && ln -s /opt/go/bin/go* /usr/bin/
RUN yum install git -y
RUN git config --global credential.helper store
RUN mkdir -p $(go env GOPATH)/bin $(go env GOPATH)/pkg $(go env GOPATH)/src
RUN export GOBIN=$(go env GOPATH)/bin