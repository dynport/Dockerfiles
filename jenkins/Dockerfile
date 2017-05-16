FROM jenkinsci/jenkins:2.61

USER root

COPY kc /usr/local/bin/kc

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
