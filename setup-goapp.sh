
yum remove epel-release -y

wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

rpm -ivh epel-release-6-8.noarch.rpm

yum install ansible -y
yum install docker-io -y
yum install git -y

service docker start
chkconfig docker on

#cd /tmp 
#wget https://github.com/jwilder/docker-gen/releases/download/0.7.3/docker-gen-linux-amd64-0.7.3.tar.gz
#tar xvzf docker-gen-linux-amd64-0.7.3.tar.gz
#cp /tmp/docker-gen /usr/bin/docker-gen

adduser --home /home/deployer --shell /bin/bash deployer
echo dep123 | passwd deployer --stdin

sed -i '/NOPASSWD/ a deployer ALL=(ALL)      NOPASSWD: ALL' /etc/sudoers

sudo su - deployer
ssh-keygen -f id_rsa -t rsa -b 4096 -N ''

git clone https://github.com/henryfernandes/godeploy.git

cd godeploy/goapp/
sudo docker build -t goapp .
sudo docker run -itd --name app1 goapp /bin/bash
sudo docker run -itd --name app2 goapp /bin/bash

cd ../nginx/
host1=`sudo docker inspect app1 | grep IPA | grep -v Sec | awk -F"\"" '{print $4}'`;
host2=`sudo docker inspect app2 | grep IPA | grep -v Sec | awk -F"\"" '{print $4}'`;
sed -i 's/host1/$host1/g' default-test.conf
sed -i 's/host1/$host2/g' default-test.conf

sudo docker build -t ginix .
sudo docker run -itd --name goloba -p 80:80 ginix /bin/bash

