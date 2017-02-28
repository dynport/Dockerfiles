FROM jenkinsci/jenkins:2.48

USER root

COPY kc /usr/local/bin/kc

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
