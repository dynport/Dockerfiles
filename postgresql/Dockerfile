FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl build-essential sudo openssl libssl-dev flex zlib1g-dev libxslt1-dev libxml2-dev python-dev libreadline-dev bison

ENV POSTGRESQL_VERSION 9.3.2
RUN mkdir -p /src && cd /src && curl -SsfL http://ftp.postgresql.org/pub/source/v$POSTGRESQL_VERSION/postgresql-$POSTGRESQL_VERSION.tar.gz | tar xfz -
RUN cd /src/postgresql-$POSTGRESQL_VERSION && ./configure && make && make install
RUN adduser --system postgres

CMD ["sudo", "-u", "postgres", "/usr/local/pgsql/bin/postgres", "-D", "/data"]
