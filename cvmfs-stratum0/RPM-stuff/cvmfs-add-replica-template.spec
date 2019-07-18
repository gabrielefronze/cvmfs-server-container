Name:       cvmfs-REPO_NAME_REPLACE_ME-add-replica
Version:    1
Release:    1
Summary:    Add replica command package for REPO_NAME_REPLACE_ME CVMFS repository.
License:    GPL

%description
This RPM adds the REPO_NAME_REPLACE_ME CVMFS repository as a replica on a running stratum-1 server.

%prep
# we have no source, so nothing here

%build

%install

%files

%post
cvmfs_server add-replica -o root http://STRATUM0_FQN_REPLACE_ME:8000/cvmfs/REPO_NAME_REPLACE_ME /etc/cvmfs/keys/REPO_NAME_REPLACE_ME.pub

%changelog