if [[ ! -z $1 ]]; then
    REPO_NAME=$1
else
    return
fi

PUB_KEY_RPM_NAME=cvmfs-pub-key-"$REPO_NAME".spec
RELMAN_KEY_RPM_NAME=cvmfs-relman-key-"$REPO_NAME".spec

cd "$HOME"/RPM-stuff
cp cvmfs-pub-key-template.spec "$PUB_KEY_RPM_NAME"
cp cvmfs-relman-key-template.spec "$RELMAN_KEY_RPM_NAME"
sed -i "s/REPO_NAME_REPLACE_ME/${REPO_NAME}/g" "$PUB_KEY_RPM_NAME"
sed -i "s/REPO_NAME_REPLACE_ME/${REPO_NAME}/g" "$RELMAN_KEY_RPM_NAME"
cd -