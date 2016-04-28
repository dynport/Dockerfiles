FROM alpine:3.3

RUN apk update && apk add curl ruby ruby-json

ENV DOCKER_VERSION=1.9.1

RUN curl -L http://get.docker.io/builds/Linux/x86_64/docker-$DOCKER_VERSION > /usr/local/bin/docker && chmod a+x /usr/local/bin/docker

COPY docker-gc.rb /opt/docker-gc.rb

CMD ["ruby", "/opt/docker-gc.rb"]
