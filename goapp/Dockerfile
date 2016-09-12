# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# Install Packages
RUN apt-get update && \
	apt-get install -y git && \
        apt-get install -y wget && \
        apt-get install -y openssh-server && \
        apt-get install -y sudo 

# gen dummy keys, centos doesn't autogen them like ubuntu does
#RUN /usr/bin/ssh-keygen -A

# Set SSH Configuration to allow remote logins without /proc write access
RUN sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd

# Create Jenkins User
RUN groupadd -g 1000 -r jenkins
RUN useradd -m -d /var/jenkins_home -s /bin/bash -u 1000 -g 1000 jenkins  

# Add public key for Jenkins login
RUN mkdir /var/jenkins_home/.ssh
COPY authorized_keys /var/jenkins_home/.ssh/authorized_keys
RUN chown -R jenkins /var/jenkins_home
RUN chgrp -R jenkins /var/jenkins_home
RUN chmod 600 /var/jenkins_home/.ssh/authorized_keys
RUN chmod 700 /var/jenkins_home/.ssh


# Add the jenkins user to sudoers
RUN echo "jenkins  ALL=(ALL)  ALL" >> /etc/sudoers

# Set Name Servers
COPY resolv.conf /etc/resolv.conf

RUN mkdir -p /go/src/app
ADD app/new.go /go/src/app/
RUN cd /go/src/app/ && go install

# Expose SSH port and run SSHD
EXPOSE 22
CMD ["/go/bin/app &"]
CMD ["/usr/sbin/sshd","-D"]


