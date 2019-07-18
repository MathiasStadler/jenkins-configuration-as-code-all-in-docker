FROM jenkins/jenkins:2.176.1

# add docker cli inside conatainer
user root
# add docker from here
# https://github.com/shazChaudhry/docker-jenkins/blob/ee0f386fd1706829b956cb2e723c0f2935496933/Dockerfile
RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update -qq && \
    apt-get install -qqy docker-ce && \
    usermod -aG docker jenkins && \
    chown -R jenkins:jenkins $JENKINS_HOME/

user jenkins

# skip the setup wizard
# ENV JAVA_ARGS -Djenkins.install.runSetupWizard=false -Dpermissive-script-security.enabled=true
# ENV JAVA_ARGS -Djenkins.install.runSetupWizard=false
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dpermissive-script-security.enabled=true"
# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# ensure that our plugin versions win, not those on disk
RUN for f in /usr/share/jenkins/ref/plugins/*.jpi; do mv $f $f.override ; done

COPY setup-tls-docker.sh /setup-tls-docker.sh 

COPY entrypoint.sh /entrypoint.sh

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY local.groovy /usr/share/jenkins/ref/init.groovy.d/

# RUN ["chmod", "+x", "/setup-tls-docker.sh"]

ENTRYPOINT ["bash","+x","/entrypoint.sh"] 

USER jenkins
