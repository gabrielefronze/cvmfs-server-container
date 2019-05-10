# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y yum-plugin-priorities
sudo rpm -Uvh http://mirror.grid.uchicago.edu/pub/osg/3.4/osg-3.4-el7-release-latest.rpm

sudo yum clean all
sudo yum update -y
sudo yum install -y frontier-squid
sudo    systemctl enable frontier-squid

cp squid.conf /etc/squid/squid.conf
cp entrypoint.sh /entrypoint.sh
sudo chmod +x /entrypoint.sh

sudo /entrypoint.sh