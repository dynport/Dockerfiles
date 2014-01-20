FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl build-essential git-core bzr mercurial

ENV GO_VERSION 1.2
RUN mkdir -p /opt/ && cd /opt/ && curl -SsfL http://go.googlecode.com/files/go$GO_VERSION.linux-amd64.tar.gz | tar xfz -

ENV GOROOT /opt/go
ENV GOPATH /go

RUN mkdir -p $GOPATH/src/github.com/dynport
RUN git clone http://github.com/dynport/dgtk.git $GOPATH/src/github.com/dynport/dgtk

ENV REVISION 7cbf38c68bec78cf53ecee3fe08aa9162051ab5d

RUN cd $GOPATH/src/github.com/dynport/dgtk && git fetch && git checkout $REVISION
RUN /opt/go/bin/go get github.com/dynport/dgtk/goproxy/goproxy

CMD ["/go/bin/goproxy"]
