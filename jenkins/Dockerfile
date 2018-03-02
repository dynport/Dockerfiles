FROM jenkinsci/jenkins:2.48

USER root

RUN curl -s https://storage.googleapis.com/kubernetes-release/release/v1.8.6/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl

COPY kc /usr/local/bin/kc

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
