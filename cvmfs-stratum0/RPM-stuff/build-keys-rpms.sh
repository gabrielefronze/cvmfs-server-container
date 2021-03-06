RPM_STUFF_PATH="/root/RPM-stuff"

OPTION="$1"
CVMFS_REPO_NAME="$2"

"$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        
case "$OPTION" in
    "--pub")
        echo -n "Exporting public key for repo $CVMFS_REPO_NAME... "
        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-pub-key-"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-pub-key-1-1.x86_64.rpm /etc/cvmfs/keys/cvmfs-"$CVMFS_REPO_NAME"-pub-key.rpm
        echo "done"
        echo "The public key is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-pub-key.rpm"
        ;;
    "--relman")
        echo -n "Exporting release manager keys set for $CVMFS_REPO_NAME... "
        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-relman-key-"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-relman-key-1-1.x86_64.rpm /etc/cvmfs/keys/cvmfs-"$CVMFS_REPO_NAME"-relman-key.rpm
        echo "done"
        echo "The release manager keys are available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-relman-key.rpm"
        ;;
    "--client-conf")
        echo -n "Exporting configuration file for $CVMFS_REPO_NAME... "

        STRATUM1_FQN=""
        PROXY_FQN="$4"

        if [[ ! -z $3 ]]; then
            STRATUM1_FQN="$3"
        else
            echo "FATAL: please provide stratum-1 FQN! Aborting"
            return
        fi

        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"

        sed -i "s/STRATUM1_FQN_REPLACE_ME/${STRATUM1_FQN}/g" "$RPM_STUFF_PATH"/cvmfs-conf-"$CVMFS_REPO_NAME".spec
        sed -i "s/PROXY_FQN_REPLACE_ME/${PROXY_FQN}/g" "$RPM_STUFF_PATH"/cvmfs-conf-"$CVMFS_REPO_NAME".spec

        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-conf-"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-conf-1-1.x86_64.rpm /etc/cvmfs/keys/cvmfs-"$CVMFS_REPO_NAME"-conf.rpm
        echo "done"
        echo "The configuration package is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-conf.rpm"
        ;;
    "--add-replica")
        echo -n "Exporting add-replica command for $CVMFS_REPO_NAME... "

        if [[ ! -z $3 ]]; then
            STRATUM0_FQN="$3"
        else
            echo "FATAL: please provide stratum-0 FQN! Aborting"
            return
        fi

        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"

        sed -i "s/STRATUM0_FQN_REPLACE_ME/${STRATUM0_FQN}/g" "$RPM_STUFF_PATH"/cvmfs-add-replica-"$CVMFS_REPO_NAME".spec

        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-add-replica-"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-add-replica-1-1.x86_64.rpm /etc/cvmfs/keys/cvmfs-"$CVMFS_REPO_NAME"-add-replica.rpm

        echo "done"
        echo "The add-replica package is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-add-replica.rpm"
    ;;
    *) 
        echo "FATAL: the second argument should be --pub (public key export), --relman (to export all the keys needed by Release Managers), --add-replica (to export the add-replica command) or --client-conf (to export client configuration). Aborting."
        ;;
esac

unset RPM_STUFF_PATH