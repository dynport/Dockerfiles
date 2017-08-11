FROM ruby:2.4.1-alpine

RUN apk update && apk add build-base sqlite-dev
RUN gem install -v 0.6.5 mailcatcher

ENTRYPOINT ["mailcatcher", "--foreground", "--http-ip=0.0.0.0", "--smtp-ip=0.0.0.0"]
