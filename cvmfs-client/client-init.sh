# Setup of connection configuration
echo "CVMFS_SERVER_URL=$CVMFS_STRATUM1_URL/cvmfs/$CVMFS_REPO_NAME" > /etc/cvmfs/default.local
echo "CVMFS_REPOSITORIES=$CVMFS_REPO_NAME" >> /etc/cvmfs/default.local
echo "CVMFS_HTTP_PROXY=http://virgo-test-02.to.infn.it:3128" >> /etc/cvmfs/default.local
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
