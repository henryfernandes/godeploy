# Start from a Centos image and install nginx.
FROM centos

# Update the OS and install nginx on the container's workspace.
RUN adduser --home /home/deployer --shell /bin/bash deployer && echo dep123 | passwd deployer --stdin
RUN mkdir -p /home/deployer/.ssh
ADD /home/deployer/.ssh/* /home/deployer/.ssh/*

RUN yum update -y &&  openssh-server -y

# Copy the conf files to the container's workspace.
#ADD default-test.conf /etc/nginx/conf.d/
#CMD service nginx restart

# Run the service restart when the container starts.
ENTRYPOINT service sshd restart && bash

# Document that the service listens on port 80.
EXPOSE 80
