Name:       cvmfs-REPO_NAME_REPLACE_ME-relman-key
Version:    1
Release:    1
Summary:    Release manager key distribution package for REPO_NAME_REPLACE_ME CVMFS repository.
License:    GPL

%description
This RPM handles the release manager key distribution for the REPO_NAME_REPLACE_ME CVMFS repository.

%prep
# we have no source, so nothing here

%build
cat /etc/cvmfs/keys/REPO_NAME_REPLACE_ME.gw > REPO_NAME_REPLACE_ME.gw
cat /etc/cvmfs/keys/REPO_NAME_REPLACE_ME.crt > REPO_NAME_REPLACE_ME.crt
cat /etc/cvmfs/keys/REPO_NAME_REPLACE_ME.pub > REPO_NAME_REPLACE_ME.pub

%install
mkdir -p %{buildroot}/etc/cvmfs/keys
install -m 0600 REPO_NAME_REPLACE_ME.gw %{buildroot}/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.gw
install -m 0400 REPO_NAME_REPLACE_ME.crt %{buildroot}/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.crt
install -m 0444 REPO_NAME_REPLACE_ME.pub %{buildroot}/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.pub

%files
/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.gw
/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.crt
/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.pub

%changelog
# let's skip this for now