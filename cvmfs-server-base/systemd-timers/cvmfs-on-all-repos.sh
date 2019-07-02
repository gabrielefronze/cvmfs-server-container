COMMAND="$1"

if [[ "$COMMAND" == "resign" || "$COMMAND" == "snapshot" ]]; then
    REPO_NAME_ARRAY=$(ls /srv/cvmfs/ | tr " " "\n" | sed "/info/d")

    for REPO in $REPO_NAME_ARRAY; do
        TIMESTAMP=$(date -u)
        echo -n "[$TIMESTAMP] performing cvmfs_server $COMMAND $REPO... "
        cvmfs_server "$COMMAND" "$REPO"
    done
else
    TIMESTAMP=$(date -u)
    echo "[$TIMESTAMP] ERROR: This command is intended to be used just with resign or snapshot cvmfs commands."
fi

unset COMMAND
unset REPO_NAME_ARRAY
unset TIMESTAMP
unset REPO