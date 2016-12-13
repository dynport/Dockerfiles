FROM ubuntu:16.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

ENV NGINX_VERSION 1.11.6
RUN apt-get install -y build-essential curl libpcre3 libpcre3-dev libpcrecpp0v5 libgd2-xpm-dev libssl-dev
RUN mkdir -p /src/
RUN cd /src && curl -Ssfl http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar xfz -

ENV NGINX_HEADERS_MORE_VERSION 0.32
RUN cd /src && curl -SsfLO "https://github.com/agentzh/headers-more-nginx-module/archive/v$NGINX_HEADERS_MORE_VERSION.tar.gz"
RUN cd /src && tar xfz v$NGINX_HEADERS_MORE_VERSION.tar.gz

RUN cd /src/nginx-$NGINX_VERSION && ./configure --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module --add-module=/src/headers-more-nginx-module-$NGINX_HEADERS_MORE_VERSION && make && make install

ENTRYPOINT ["/usr/local/nginx/sbin/nginx"]
