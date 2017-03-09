FROM alpine:3.5

RUN apk update && apk add bash docker py2-pip ca-certificates pv jq git tar curl rsync
RUN pip install awscli

CMD ["/bin/bash"]
