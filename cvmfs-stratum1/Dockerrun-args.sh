# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

CVMFS_ROOT_DIR="$1"
CVMFS_CONTAINER_IMAGE_NAME="$2"

mkdir -p "$CVMFS_ROOT_DIR"/var-spool-cvmfs
mkdir "$CVMFS_ROOT_DIR"/cvmfs

docker run -d \
-p 8000:8000 80:80 \
--name cvmfs-stratum1 \
--hostname cvmfs-stratum1 \
--privileged \
--mount type=bind,source="$CVMFS_ROOT_DIR"/var-spool-cvmfs,target=/var/spool/cvmfs \
--mount type=bind,source="$CVMFS_ROOT_DIR"/cvmfs,target=/cvmfs \
--volume "$CVMFS_ROOT_DIR"/srv-cvmfs:/srv/cvmfs \
--volume "$CVMFS_ROOT_DIR"/etc-cvmfs:/etc/cvmfs \
--volume /sys/fs/cgroup:/sys/fs/cgroup \
"$CVMFS_CONTAINER_IMAGE_NAME"

unset CVMFS_ROOT_DIR
unset CVMFS_CONTAINER_IMAGE_NAME
