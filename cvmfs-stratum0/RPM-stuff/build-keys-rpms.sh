RPM_STUFF_PATH="/root/RPM-stuff"

OPTION="$1"
CVMFS_REPO_NAME="$2"

"$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        
case "$OPTION" in
    "--pub")
        echo -n "Exporting public key for repo $CVMFS_REPO_NAME... "
        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-pub-key-"$CVMFS_REPO_NAME".spec
        rm -f "$RPM_STUFF_PATH"/*"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-pub-key-1-1.x86_64.rpm /etc/cvmfs/keys
        echo "done"
        echo "The public key is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-pub-key-1-1.x86_64.rpm"
        ;;
    "--relman")
        echo -n "Exporting release manager keys set for $CVMFS_REPO_NAME... "
        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"
        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-relman-key-"$CVMFS_REPO_NAME".spec
        rm -f "$RPM_STUFF_PATH"/*"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-relman-key-1-1.x86_64.rpm /etc/cvmfs/keys
        echo "done"
        echo "The public key is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-relman-key-1-1.x86_64.rpm"
        ;;
    "--conf")
        echo -n "Exporting configuration file for $CVMFS_REPO_NAME... "

        STRATUM1_FQN=""
        PROXY_FQN=""

        if [[ ! -z $3 ]]; then
            STRATUM1_FQN="$3"
        else
            echo "FATAL: please provide stratum 1 FQN! Aborting"
            return
        fi

        if [[ ! -z $4 ]]; then
            PROXY_FQN="$4"
        else
            PROXY_FQN="DIRECT"
        fi

        source "$RPM_STUFF_PATH"/setup-rpmspecs.sh "$CVMFS_REPO_NAME"

        sed -i "s/STRATUM1_FQN_REPLACE_ME/${STRATUM1_FQN}/g" "$RPM_STUFF_PATH"/cvmfs-conf-"$CVMFS_REPO_NAME".spec
        sed -i "s/PROXY_FQN_REPLACE_ME/${PROXY_FQN}/g" "$RPM_STUFF_PATH"/cvmfs-conf-"$CVMFS_REPO_NAME".spec

        rpmbuild -ba "$RPM_STUFF_PATH"/cvmfs-conf-"$CVMFS_REPO_NAME".spec
        rm -f "$RPM_STUFF_PATH"/*"$CVMFS_REPO_NAME".spec
        cp -f /root/rpmbuild/RPMS/x86_64/cvmfs-"$CVMFS_REPO_NAME"-relman-key-1-1.x86_64.rpm /etc/cvmfs/keys
        echo "done"
        echo "The public key is available at /etc/cvmfs/keys/cvmfs-$CVMFS_REPO_NAME-relman-key-1-1.x86_64.rpm"
        ;;
    *) 
        echo "FATAL: the second argument should be --pub (public key export), --relman (to export all the keys needed by Release Managers) or --conf to export client configuration. Aborting."
        ;;
esac

unset RPM_STUFF_PATH