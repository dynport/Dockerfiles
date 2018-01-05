FROM fedora:27

COPY google-cloud-sdk.sh /etc/yum.repos.d/google-cloud-sdk.repo

RUN dnf update -y && dnf install -y bzip2 bzr ca-certificates curl dirmngr docker docker-compose git gnupg2 google-cloud-sdk java-1.8.0-openjdk mercurial openssh-clients procps subversion unzip wget which xz golang

ARG KUBERNETES_VERSION=1.7.5
RUN curl -SsfL https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl

ARG JENKINS_VERSION=2.100
RUN mkdir -p /opt && curl -SsfL http://mirrors.jenkins.io/war/${JENKINS_VERSION}/jenkins.war > /opt/jenkins.war
ENV JENKINS_HOME=/var/jenkins_home

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"] 
