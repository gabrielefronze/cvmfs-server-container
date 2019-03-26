# This file is subject to the terms and conditions defined by
# the Creative Commons BY-NC-CC standard and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

CVMFS_ROOT_DIR=/var/cvmfs-docker/stratum1
CVMFS_CONTAINER_IMAGE_NAME=slidspitfire/cvmfs-stratum1-base:latest

sh Dockerrun-args.sh $CVMFS_ROOT_DIR $CVMFS_CONTAINER_IMAGE_NAME

unset CVMFS_ROOT_DIR
unset CVMFS_CONTAINER_IMAGE_NAME
