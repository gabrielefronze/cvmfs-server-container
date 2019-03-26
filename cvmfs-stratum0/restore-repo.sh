# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

REPO_NAME="$1"

# Recreate the httpd configuration file
if [[ ! -f /etc/httpd/conf.d/cvmfs."$REPO_NAME".conf ]]; then
    echo "Recreating httpd configuration files for $REPO_NAME"
    cp /etc/cvmfs-scripts/cvmfs-httpd-conf.template /etc/httpd/conf.d/cvmfs."$REPO_NAME".conf
    sed -i "s/DUMMY_REPLACE_ME/${REPO_NAME}/g" /etc/httpd/conf.d/cvmfs."$REPO_NAME".conf
    systemctl restart httpd
fi

# Recreate fstab entries and restore unit mounts
if [[ ! -f /etc/fstab ]]; then
    touch /etc/fstab
fi

countFound=`grep -c "${REPO_NAME}" /etc/fstab`
shouldBe=`grep -c DUMMY_REPLACE_ME /etc/cvmfs-scripts/cvmfs-fstab.template`

if [[ "$countFound" < "$shouldBe" ]]; then
    echo "Recreating fstab entries for $REPO_NAME... "
    cp /etc/cvmfs-scripts/cvmfs-fstab.template /etc/"$REPO_NAME"-fstab
    sed -i "s/DUMMY_REPLACE_ME/${REPO_NAME}/g" /etc/"$REPO_NAME"-fstab

    if [[ ! "$countFound" == 0 ]]; then
        echo "Removing leftaround in fstab to add a new and clean entry.. "
        sed -i "/${REPO_NAME}/d" /etc/fstab
    fi

    (cat /etc/"$REPO_NAME"-fstab; echo) >> /etc/fstab
    rm -f /etc/"$REPO_NAME"-fstab

    echo "Restoring systemd mount services..."
    /usr/lib/systemd/system-generators/systemd-fstab-generator /run/systemd/generator '' ''
    systemctl daemon-reload
fi

# Unmount everything mounted by fstab
echo "Unmounting $REPO_NAME left arounds..."
umount overlay_"$REPO_NAME"
umount /dev/fuse

# Eventually remove transaction locks left dangling since everything will be mounted read-only
if [[ -f /var/spool/cvmfs/"$REPO_NAME"/in_transaction.lock ]]; then
    echo "Removing transaction locks..."
    rm -f /var/spool/cvmfs/"$REPO_NAME"/in_transaction.lock
fi

# Remount everything using cvmfs_server
echo "Mounting cvmfs $REPO_NAME repository..."
cvmfs_server mount "$REPO_NAME"

# Checking repo using cvmfs_server
echo "Checking cvmfs $REPO_NAME repository..."
cvmfs_server check "$REPO_NAME"
