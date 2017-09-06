FROM alpine:edge

RUN apk update && \
    apk upgrade && \
    apk add curl go && \
    mkdir -p /code && \
    curl -SsfL https://github.com/coreos/sdnotify-proxy/archive/master.tar.gz | tar xfz -  && \
    cd sdnotify-proxy-master && \
    GOBIN=/usr/local/bin sh ./build && \
    mv ./bin/sdnotify-proxy /usr/local/bin/ && \
    apk del --purge curl go
