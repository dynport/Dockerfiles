FROM google/cloud-sdk:169.0.0

# COPY google-cloud-sdk.sh /etc/yum.repos.d/google-cloud-sdk.repo

RUN apt update && apt install -y curl maven git golang google-cloud-sdk

RUN curl -SsfL https://storage.googleapis.com/kubernetes-release/release/v1.7.5/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl


# Create workspace directory for Jenkins
RUN mkdir /workspace && \
	chmod 777 /workspace

# Download the latest Jenkins swarm client with curl - version 3.3
# Browse all versions here: https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/
RUN curl -o /swarm-client.jar -s https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.3/swarm-client-3.3.jar

COPY entrypoint.sh /

ENTRYPOINT ["bash", "/entrypoint.sh"]
