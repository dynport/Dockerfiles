FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

ENV RUBY_VERSION 2.0.0-p353
RUN apt-get -y install curl build-essential libyaml-dev libxml2-dev libxslt1-dev libreadline-dev libssl-dev zlib1g-dev
RUN cd /tmp && curl -SsfLO http://ftp.ruby-lang.org/pub/ruby/$(echo $RUBY_VERSION | cut -d "." -f 1-2)/ruby-$RUBY_VERSION.tar.gz
RUN cd /tmp && tar xvfz ruby-$RUBY_VERSION.tar.gz
RUN cd /tmp/ruby-$RUBY_VERSION && ./configure --disable-install-doc && make && make install
