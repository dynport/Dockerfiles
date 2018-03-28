FROM fedora:27

COPY google-cloud-sdk.sh /etc/yum.repos.d/google-cloud-sdk.repo

ARG GCLOUD_VERSION

RUN dnf update -y && dnf install -y java-9-openjdk-headless google-cloud-sdk-${GCLOUD_VERSION} curl maven git golang awscli

ARG GITHUB_TOKEN
COPY kc /usr/local/bin/kc
RUN curl -SsfL https://storage.googleapis.com/kubernetes-release/release/v1.9.2/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl /usr/local/bin/kc

# Create workspace directory for Jenkins
RUN mkdir /workspace && \
	chmod 777 /workspace

# Download the latest Jenkins swarm client with curl - version 3.3
# Browse all versions here: https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/
RUN curl -o /swarm-client.jar -s https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.12/swarm-client-3.12.jar

COPY entrypoint.sh /

ENTRYPOINT ["bash", "/entrypoint.sh"]
