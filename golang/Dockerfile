FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl build-essential git-core bzr mercurial

ENV GO_VERSION 1.10
RUN mkdir -p /opt/ && cd /opt/ && curl -SsfL https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz | tar xfz - \
  && ln -s /opt/go/bin/go /usr/local/bin/go

RUN mkdir /go

ENV GOROOT /opt/go
ENV GOPATH /go
