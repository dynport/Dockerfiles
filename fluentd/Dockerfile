FROM gcr.io/google_containers/fluentd-elasticsearch:1.20

RUN apt-get update && apt-get upgrade -y && apt-get install -y iproute libsystemd0 && rm -rf /var/lib/apt/lists/* 
RUN /usr/sbin/td-agent-gem install fluent-plugin-kubernetes_metadata_filter fluent-plugin-kinesis fluent-plugin-remote_syslog

ENTRYPOINT ["/usr/sbin/td-agent"]
