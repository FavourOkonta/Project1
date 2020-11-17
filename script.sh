#! /bin/bash
sudo yum update -y
sudo yum install java git -y
sudo amazon-linux-extras install docker -y
sudo usermod -aG docker ec2-user
sudo service docker start
sudo curl -L github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo cp /usr/local/bin/docker-compose /usr/bin/
sudo cp /usr/local/bin/docker-compose /home/ec2-user/
sudo mkdir /usr/config
sudo docker pull prom/node-exporter
