# This script is intended to install docker and setup the environment on CentOS 7

sudo yum install -y -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce

sudo usermod -aG docker $(whoami)

sudo systemctl enable docker.service

sudo systemctl start docker.service
