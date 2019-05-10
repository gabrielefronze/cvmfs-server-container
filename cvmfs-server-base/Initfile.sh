# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

sudo yum update -y && yum -y install man nano wget epel-release jq

wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
sudo yum install -y cvmfs-release-latest.noarch.rpm
sudo rm -rf cvmfs-release-latest.noarch.rpm
sudo yum install -y cvmfs cvmfs-server
sudo echo "CVMFS_HTTP_PROXY=DIRECT" > /etc/cvmfs/default.local

sudo systemctl enable httpd.service
sudo sed '/Listen 80/ a Listen 8000' -i /etc/httpd/conf/httpd.conf

sudo mkdir /etc/cvmfs-scripts
sudo cp restore-repo.sh /etc/cvmfs-scripts
sudo cp cvmfs-httpd-conf.template /etc/cvmfs-scripts
sudo cp cvmfs-fstab.template /etc/cvmfs-scripts
sudo chmod +x /etc/cvmfs-scripts/restore-repo.sh

sudo /usr/sbin/init
