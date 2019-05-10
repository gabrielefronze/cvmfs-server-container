# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

sudo source ../cvmfs-server-base/Initfile.sh

sudo yum install -y cvmfs-gateway

sudo systemctl enable cvmfs-gateway.service

sudo /usr/sbin/init
