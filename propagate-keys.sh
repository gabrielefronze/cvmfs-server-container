# This file is subject to the terms and conditions defined by
# the Creative Commons BY-NC-CC standard and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

docker cp /var/cvmfs-docker/stratum0/etc/cvmfs/keys/virgo.sw.pub cvmfs-stratum1:/etc/cvmfs/keys
docker cp /var/cvmfs-docker/stratum0/etc/cvmfs/keys/virgo.sw.pub cvmfs-client:/etc/cvmfs/keys
