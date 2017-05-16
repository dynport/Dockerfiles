FROM alpine:3.5
ARG GOPATH

RUN apk update && apk add bash docker py2-pip ca-certificates pv jq git tar curl rsync
RUN pip install awscli

COPY cleanup_build_server.sh ./
RUN chmod +x cleanup_build_server.sh

CMD ["/bin/bash"]
