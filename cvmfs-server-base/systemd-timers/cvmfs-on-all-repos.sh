LOG_DIR="/var/log/cvmfs/"
LOG_FILE="$LOG_DIR/cvmfs-timers.log"

if [[ ! -d $LOG_DIR ]]; then
    mkdir -p "$LOG_DIR"
fi

if [[ ! -f $LOG_FILE ]]; then
    touch $LOG_FILE
fi

COMMAND="$1"

if [[ "$COMMAND" == "resign" || "$COMMAND" == "snapshot" ]]; then
    REPO_NAME_ARRAY=$(ls /cvmfs/ | tr " " "\n")

    for REPO in $REPO_NAME_ARRAY; do
        TIMESTAMP=$(date -u)
        echo -n "[$TIMESTAMP] performing cvmfs_server $COMMAND $REPO... " >> $LOG_FILE
        cvmfs_server "$COMMAND" "$REPO" >> $LOG_FILE
    done
else
    TIMESTAMP=$(date -u)
    echo "[$TIMESTAMP] ERROR: This command is intended to be used just with resign or snapshot cvmfs commands." >> $LOG_FILE
fi

unset COMMAND
unset REPO_NAME_ARRAY
unset TIMESTAMP
unset REPO