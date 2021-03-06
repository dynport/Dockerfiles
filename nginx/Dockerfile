FROM ubuntu:16.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

ENV NGINX_VERSION 1.11.6
RUN apt-get install -y build-essential curl libpcre3 libpcre3-dev libpcrecpp0v5 libgd2-xpm-dev libssl-dev zlib1g-dev
RUN mkdir -p /src/
RUN cd /src && curl -Ssfl http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar xfz -

# download headers more module
ENV NGINX_HEADERS_MORE_VERSION 0.32
RUN cd /src && curl -SsfLO "https://github.com/agentzh/headers-more-nginx-module/archive/v$NGINX_HEADERS_MORE_VERSION.tar.gz"
RUN cd /src && tar xfz v$NGINX_HEADERS_MORE_VERSION.tar.gz

# download mod page speed
ENV NPS_VERSION 1.12.34.2
RUN cd /src && curl -SsfLO "https://github.com/pagespeed/ngx_pagespeed/archive/v$NPS_VERSION-beta.tar.gz"
RUN cd /src && tar xfz "v${NPS_VERSION}-beta.tar.gz"
RUN cd "/src/ngx_pagespeed-${NPS_VERSION}-beta/" && psol_url="https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz" 
RUN cd "/src/ngx_pagespeed-${NPS_VERSION}-beta/" && [ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL) && curl -SsfLO  ${psol_url} && tar -xzvf $(basename ${psol_url})

RUN cd /src/nginx-$NGINX_VERSION && \
  ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed' --add-module=/src/headers-more-nginx-module-$NGINX_HEADERS_MORE_VERSION --add-module=/src/ngx_pagespeed-${NPS_VERSION}-beta ${PS_NGX_EXTRA_FLAGS} && \
  make && make install

RUN mkdir -p /var/cache/nginx /var/log/nginx && ln -sf /dev/stdout /var/log/nginx/access.log  && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
