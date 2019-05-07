if [[ -z $1 ]]; then
    echo "Please provide repo name..."
    exit 1
fi

REPO_NAME="$1"
SERVER_NAME="${2:-cvmfs0.virgo.infn.it}"

echo "Setting up publisher for repo $REPO_NAME on server $SERVER_NAME."

cvmfs_server mkfs -w http://"$SERVER_NAME"/cvmfs/"$REPO_NAME" \
                         -u gw,/srv/cvmfs/"$REPO_NAME"/data/txn,http://"$SERVER_NAME":4929/api/v1 \
                         -k /etc/cvmfs/keys -o `whoami` "$REPO_NAME"