FROM fedora:27

COPY google-cloud-sdk.sh /etc/yum.repos.d/google-cloud-sdk.repo

RUN dnf update -y && dnf install -y bzip2 bzr ca-certificates curl dirmngr docker docker-compose git gnupg2 google-cloud-sdk java-1.8.0-openjdk mercurial openssh-clients procps subversion unzip wget which xz golang

ARG JENKINS_VERSION=2.113
RUN mkdir -p /opt && curl -SsfL http://mirrors.jenkins.io/war/${JENKINS_VERSION}/jenkins.war > /opt/jenkins.war
ENV JENKINS_HOME=/var/jenkins_home

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"] 
