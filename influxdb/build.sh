#!/bin/bash
set -xe

VERSION=0.13.0

DIR=$(mktemp -d /tmp/influx-XXXX)
trap "rm -Rf $DIR" EXIT

pushd $DIR > /dev/null

curl -SsfL https://dl.influxdata.com/influxdb/releases/influxdb-${VERSION}_linux_amd64.tar.gz | tar xz
bin_path=$(find . -type f -name "influxd" | grep "/bin/")

if [[ -z $bin_path ]]; then
  echo "unable to find influxdb"
  exit 1
fi


mkdir -p docker
mv $bin_path docker/

cat > docker/Dockerfile <<EOF
FROM busybox:ubuntu-14.04

MAINTAINER Jason Wilder "<jason@influxdb.com>"

# admin, http, udp, cluster, graphite, opentsdb, collectd
EXPOSE 8083 8086 8086/udp 8088 2003 4242 25826

WORKDIR /app

# copy binary into image
COPY influxd /app/

# Add influxd to the PATH
ENV PATH=/app:$PATH

# Generate a default config
RUN influxd config > /etc/influxdb.toml

# Use /data for all disk storage
RUN sed -i 's/dir = "\/.*influxdb/dir = "\/data/' /etc/influxdb.toml

VOLUME ["/data"]

ENTRYPOINT ["influxd", "--config", "/etc/influxdb.toml"]
EOF

pushd docker > /dev/null

ls -la

docker build -t dynport/influxdb:$VERSION .
