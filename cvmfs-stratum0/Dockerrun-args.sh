# This file is subject to the terms and conditions defined by
# the Creative Commons BY-NC-CC standard and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

CVMFS_ROOT_DIR="$1"
CVMFS_CONTAINER_IMAGE_NAME="$2"

mkdir -p "$CVMFS_ROOT_DIR"/var-spool-cvmfs
mkdir -p "$CVMFS_ROOT_DIR"/cvmfs
mkdir -p "$CVMFS_ROOT_DIR"/srv-cvmfs
mkdir -p "$CVMFS_ROOT_DIR"/etc-cvmfs

docker run -d \
-p 8000:8000 \
--name cvmfs-stratum0 \
--hostname cvmfs-stratum0 \
--privileged \
--mount type=bind,source="$CVMFS_ROOT_DIR"/var-spool-cvmfs,target=/var/spool/cvmfs,bind-propagation=rshared,consistency=consistent \
--mount type=bind,source="$CVMFS_ROOT_DIR"/cvmfs,target=/cvmfs,bind-propagation=rshared,consistency=consistent \
--mount type=bind,source="$CVMFS_ROOT_DIR"/srv-cvmfs,target=/srv/cvmfs,bind-propagation=rshared,consistency=consistent \
--mount type=bind,source="$CVMFS_ROOT_DIR"/etc-cvmfs,target=/etc/cvmfs,bind-propagation=rshared,consistency=consistent \
--volume /sys/fs/cgroup:/sys/fs/cgroup \
"$CVMFS_CONTAINER_IMAGE_NAME"

unset CVMFS_ROOT_DIR
unset CVMFS_CONTAINER_IMAGE_NAME
