FROM jenkins/jenkins:2.103

USER root

RUN curl -s https://storage.googleapis.com/kubernetes-release/release/v1.5.4/bin/linux/amd64/kubectl > /usr/local/bin/kubectl
RUN chmod a+x /usr/local/bin/kubectl

COPY kc /usr/local/bin/kc

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
