FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl build-essential git-core bzr mercurial

ENV GO_VERSION 1.2
RUN mkdir -p /opt/ && cd /opt/ && curl -SsfL http://go.googlecode.com/files/go$GO_VERSION.linux-amd64.tar.gz | tar xfz -

RUN mkdir /go

ENV GOROOT /opt/go
ENV GOPATH /go
