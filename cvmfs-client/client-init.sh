if [[ -z $1 ]]; then
    echo "Please provide repo name..."
    exit 1
fi

REPO_NAME="$1"
SERVER_NAME="${2:-cvmfs-stratum1}"

echo "Setting up client for repo $REPO_NAME on server $SERVER_NAME."

# Setup of connection configuration
echo "CVMFS_SERVER_URL=http://$SERVER_NAME/cmvfs/$REPO_NAME" > /etc/cvmfs/default.local
echo "CVMFS_REPOSITORIES=$REPO_NAME" >> /etc/cvmfs/default.local
echo "CVMFS_HTTP_PROXY=http://$SERVER_NAME:3128" >> /etc/cvmfs/default.local
echo "CVMFS_CACHE_BASE=/cvmfs-cache" >> /etc/cvmfs/default.local
echo "CVMFS_QUOTA_LIMIT=10240" >> /etc/cvmfs/default.local

# Disable SELinux
setenforce 0

# Setting up cvmfs
cvmfs_config setup

# Restarting autofs
service autofs restart

# Checking connectivity
cvmfs_config probe
cvmfs_config chksetup
