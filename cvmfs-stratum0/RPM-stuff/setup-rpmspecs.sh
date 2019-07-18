if [[ ! -z $1 ]]; then
    REPO_NAME=$1
    PUB_KEY_RPM_NAME=cvmfs-pub-key-"$REPO_NAME".spec
    RELMAN_KEY_RPM_NAME=cvmfs-relman-key-"$REPO_NAME".spec
    CONF_RPM_NAME=cvmfs-conf-"$REPO_NAME".spec
    ADD_REPLICA_RPM_NAME=cvmfs-add-replica-"$REPO_NAME".spec

    cd "$HOME"/RPM-stuff
    cp -f cvmfs-pub-key-template.spec "$PUB_KEY_RPM_NAME"
    cp -f cvmfs-relman-key-template.spec "$RELMAN_KEY_RPM_NAME"
    cp -f cvmfs-conf-template.spec "$CONF_RPM_NAME"
    cp -f cvmfs-add-replica-template.spec "$ADD_REPLICA_RPM_NAME"
    
    sed -i "s/REPO_NAME_REPLACE_ME/${REPO_NAME}/g" "$PUB_KEY_RPM_NAME"
    sed -i "s/REPO_NAME_REPLACE_ME/${REPO_NAME}/g" "$RELMAN_KEY_RPM_NAME"
    sed -i "s/REPO_NAME_REPLACE_ME/${REPO_NAME}/g" "$CONF_RPM_NAME"
    sed -i "s/REPO_NAME_REPLACE_ME/${REPO_NAME}/g" "$ADD_REPLICA_RPM_NAME"
    cd -
fi