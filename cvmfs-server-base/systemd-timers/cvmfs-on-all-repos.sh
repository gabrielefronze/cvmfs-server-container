COMMAND = "$1"

if [[ "$COMMAND" == "resign" || "$COMMAND" == "snapshot" ]]; then

    REPO_LIST=($(cvmfs_server list | awk '{print $1}'))
    REPO_LIST_LENGTH="${#REPO_LIST[@]}"

    for REPO in "$REPOLIST"; do
        echo "performing cvmfs_server $COMMAND $REPO"
        cvmfs_server "$COMMAND" "$REPO"

else

    echo "ERROR: This command is intended to be used just with resign or snapshot cvmfs commands."
    return 1

fi