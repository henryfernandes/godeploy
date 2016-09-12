# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# Install Packages
RUN apt-get update && \
	apt-get install -y git && \
        apt-get install -y wget && \
        apt-get install -y openssh-server && \
        apt-get install -y java-1.8.0-openjdk && \
        apt-get install -y sudo && \

# gen dummy keys, centos doesn't autogen them like ubuntu does
#RUN /usr/bin/ssh-keygen -A

# Set SSH Configuration to allow remote logins without /proc write access
RUN sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd

# Create Jenkins User
RUN useradd jenkins -m -s /bin/bash

# Add public key for Jenkins login
RUN mkdir /home/jenkins/.ssh
COPY /files/authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins /home/jenkins
RUN chgrp -R jenkins /home/jenkins
RUN chmod 600 /home/jenkins/.ssh/authorized_keys
RUN chmod 700 /home/jenkins/.ssh



# Add the jenkins user to sudoers
RUN echo "jenkins  ALL=(ALL)  ALL" >> etc/sudoers

# Set Name Servers
COPY /files/resolv.conf /etc/resolv.conf

RUN mkdir -p /go/src/app
ADD app/new.go /go/src/app/
RUN cd /go/src/app/ && go install

# Expose SSH port and run SSHD
EXPOSE 22
CMD ["/go/bin/app &"]
CMD ["/usr/sbin/sshd","-D"]


