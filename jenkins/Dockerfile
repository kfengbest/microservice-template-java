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

# install maven
RUN tar xzf /tmp/apache-maven-3.2.2.tar.gz -C /opt/; \
  ln -s /opt/apache-maven-3.2.2 /opt/maven; \
  ln -s /opt/maven/bin/mvn /usr/local/bin; \
  rm -f /tmp/apache-maven-3.2.2.tar.gz
ENV MAVEN_HOME /opt/maven