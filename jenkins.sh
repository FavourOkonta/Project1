#! /bin/bash
sudo yum update -y
sudo yum install git java -y
sudo service docker start
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins --nogpgcheck -y
sudo wget https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip
sudo unzip terraform_0.13.3_linux_amd64.zip
sudo cp terraform  /usr/bin/
wget https://releases.hashicorp.com/packer/1.5.4/packer_1.5.4_linux_amd64.zip
unzip packer_1.5.4_linux_amd64.zip
sudo mv packer /usr/local/bin/.
sudo amazon-linux-extras install ansible2