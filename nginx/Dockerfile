FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

ENV NGINX_VERSION 1.4.4
RUN apt-get install -y build-essential curl libpcre3 libpcre3-dev libpcrecpp0 libgd2-xpm-dev libssl-dev
RUN mkdir -p /src/
RUN cd /src && curl -Ssfl http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar xfz -

ENV NGINX_SYSLOG_PATCH_VERSION 1.3.14
RUN mkdir -p /src/nginx_syslog_patch
RUN cd /src/nginx_syslog_patch && curl -SsfLO https://raw.github.com/yaoweibin/nginx_syslog_patch/master/config
RUN cd /src/nginx_syslog_patch && curl -SsfLO https://raw.github.com/yaoweibin/nginx_syslog_patch/master/syslog_$NGINX_SYSLOG_PATCH_VERSION.patch
RUN cd /src/nginx-$NGINX_VERSION && patch -p1 < /src/nginx_syslog_patch/syslog_$NGINX_SYSLOG_PATCH_VERSION.patch

ENV NGINX_HEADERS_MORE_VERSION 0.24
RUN cd /src && curl -SsfLO "https://github.com/agentzh/headers-more-nginx-module/archive/v$NGINX_HEADERS_MORE_VERSION.tar.gz"
RUN cd /src && tar xfz v$NGINX_HEADERS_MORE_VERSION.tar.gz

# compile nginx
RUN cd /src/nginx-$NGINX_VERSION && ./configure --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module --with-http_spdy_module --add-module=/src/nginx_syslog_patch --add-module=/src/headers-more-nginx-module-$NGINX_HEADERS_MORE_VERSION && make && make install

