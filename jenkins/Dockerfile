# Start from a Centos image and install nginx.
FROM jenkins


RUN mkdir /var/jenkins_home/.ssh
COPY $HOME/godeploy/files/authorized_keys /var/jenkins_home/.ssh/authorized_keys
RUN chown -R jenkins /var/jenkins_home
RUN chgrp -R jenkins /var/jenkins_home
RUN chmod 600 /var/jenkins_home/.ssh/authorized_keys
RUN chmod 700 /var/jenkins_home/.ssh

RUN echo "host1		app1" >> /etc/hosts
RUN echo "host2		app2" >> /etc/hosts

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

RUN mkdir -p /var/jenkins_home/jobs/Goapp
COPY config-goapp.xml /var/jenkins_home/jobs/Goapp/config.xml

# Document that the service listens on port 80.
EXPOSE 8080

CMD ["/usr/local/bin/jenkins.sh &"]


