REPO_NAME="$1"
SERVER_NAME="$2"
PROXY_NAME=""

if [[ ! -z $3 ]]; then
    PROXY_NAME="http://$3:3128"
else
    PROXY_NAME="DIRECT"
fi

# Setup of connection configuration
echo "CVMFS_SERVER_URL=http://$SERVER_NAME/cmvfs/$REPO_NAME"
echo "CVMFS_REPOSITORIES=$REPO_NAME"
echo "CVMFS_HTTP_PROXY=http://$SERVER_NAME:3128"
echo "CVMFS_CACHE_BASE=/cvmfs-cache"
echo "CVMFS_QUOTA_LIMIT=10240"