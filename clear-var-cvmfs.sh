echo "WARNING: this script is intended to remove ALL CVMFS data in a test environment."
echo "If you are not COMPLETELY SURE of what will happen EXIT IMMEDIATELY using Ctrl-C!"
read -p "Otherwise press [ENTER] to continue..."

if [[ -z $1 ]]; then
    read -p "Please provide the CVMFS host root and pres [ENTER]: " HOST_CVMFS_ROOT_DIR
else
    HOST_CVMFS_ROOT_DIR="$1"
fi

# Unmounting folders
REPO_NAME_ARRAY=$(ls $HOST_CVMFS_ROOT_DIR/srv-cvmfs/ | tr " " "\n" | sed "/info/d")

for REPO_NAME in $REPO_NAME_ARRAY
do
    umount overlay_"$REPO_NAME"
done
umount /dev/fuse

# Removing the tree folder
rm -rf $HOST_CVMFS_ROOT_DIR