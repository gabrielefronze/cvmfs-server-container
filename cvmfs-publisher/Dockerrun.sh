# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

CVMFS_ROOT_DIR=/scratch/cvmfs-docker/stratum0
CVMFS_CONTAINER_IMAGE_NAME=slidspitfire/cvmfs-publisher:latest

sh Dockerrun-args.sh $CVMFS_ROOT_DIR $CVMFS_CONTAINER_IMAGE_NAME

unset CVMFS_ROOT_DIR
unset CVMFS_CONTAINER_IMAGE_NAME