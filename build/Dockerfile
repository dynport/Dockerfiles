FROM google/cloud-sdk:169.0.0-alpine
RUN echo http://mirror.yandex.ru/mirrors/alpine/v3.5/main > /etc/apk/repositories; \
    echo http://mirror.yandex.ru/mirrors/alpine/v3.5/community >> /etc/apk/repositories

ARG GOPATH

RUN apk update && apk add bash docker py2-pip ca-certificates pv jq git tar curl rsync
RUN pip install awscli

CMD ["/bin/bash"]
