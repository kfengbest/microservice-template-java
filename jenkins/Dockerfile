FROM jenkins/jenkins:lts

USER root

#RUN /usr/local/bin/install-plugins.sh workflow-aggregator job-dsl git mailer pipeline-model-definition aws-credentials s3 pipeline-aws

COPY ./plugins.txt /usr/share/jenkins/plugins.txt
RUN cat /usr/share/jenkins/plugins.txt | xargs /usr/local/bin/install-plugins.sh

COPY ./.credentials /usr/share/jenkins/ref/init.groovy.d/
COPY ./configs /usr/share/jenkins/ref/init.groovy.d/
COPY ./init.groovy.d /usr/share/jenkins/ref/init.groovy.d/

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# get maven 3.2.2 and verify its checksum
RUN wget --no-verbose -O /tmp/apache-maven-3.2.2.tar.gz http://archive.apache.org/dist/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz; \
  echo "87e5cc81bc4ab9b83986b3e77e6b3095 /tmp/apache-maven-3.2.2.tar.gz" | md5sum -c

RUN apt-get update && apt-get install -y zip unzip

# install maven
RUN tar xzf /tmp/apache-maven-3.2.2.tar.gz -C /opt/; \
  ln -s /opt/apache-maven-3.2.2 /opt/maven; \
  ln -s /opt/maven/bin/mvn /usr/local/bin; \
  rm -f /tmp/apache-maven-3.2.2.tar.gz
ENV MAVEN_HOME /opt/maven

# Install prerequisites for Docker
RUN apt-get update && apt-get install -y sudo maven iptables libsystemd-journal0 init-system-helpers libapparmor1 libltdl7 libseccomp2 libdevmapper1.02.1 && rm -rf /var/lib/apt/lists/*
ENV DOCKER_VERSION=docker-ce_17.03.0~ce-0~ubuntu-trusty_amd64.deb
ENV KUBERNETES_VERSION=v1.6.6
# Set up Docker
RUN wget https://download.docker.com/linux/ubuntu/dists/trusty/pool/stable/amd64/$DOCKER_VERSION
RUN dpkg -i $DOCKER_VERSION
# Set up Kubernetes
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
# Configure access to the Kubernetes Cluster
ADD install/config ~/.kube