# Start from a Centos image and install nginx.
FROM jenkins

USER root
RUN mkdir /var/jenkins_home/.ssh
COPY id_rsa /var/jenkins_home/.ssh/id_rsa
COPY id_rsa.pub /var/jenkins_home/.ssh/id_rsa.pub
COPY authorized_keys /var/jenkins_home/.ssh/authorized_keys
RUN chmod 600 /var/jenkins_home/.ssh/*
RUN chmod 700 /var/jenkins_home/.ssh

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

RUN mkdir -p /var/jenkins_home/jobs/Goapp
COPY config-goapp.xml /var/jenkins_home/jobs/Goapp/config.xml
COPY resolv.conf /etc/resolv.conf

USER root
RUN chown -R jenkins /var/jenkins_home
RUN chgrp -R jenkins /var/jenkins_home

#RUN jenkins.sh &
# Document that the service listens on port 80.
EXPOSE 8080

ENTRYPOINT ["jenkins.sh", "&"] 


