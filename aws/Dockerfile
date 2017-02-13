FROM alpine:3.5

RUN apk update && apk add py2-pip curl jq
RUN pip install awscli

ENTRYPOINT ["/usr/bin/aws"]
