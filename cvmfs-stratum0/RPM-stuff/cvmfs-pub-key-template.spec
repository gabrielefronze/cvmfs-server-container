Name:       cvmfs-REPO_NAME_REPLACE_ME-pub-key
Version:    1
Release:    1
Summary:    Public key distribution package for REPO_NAME_REPLACE_ME CVMFS repository.
License:    GPL

%description
This RPM handles the public key distribution for the REPO_NAME_REPLACE_ME CVMFS repository.

%prep
# we have no source, so nothing here

%build
cat /etc/cvmfs/keys/REPO_NAME_REPLACE_ME.pub > REPO_NAME_REPLACE_ME.pub
bash ./echo-repo-conf.sh REPO_NAME_REPLACE_ME $(hostname --ip-address) > REPO_NAME_REPLACE_ME.conf

%install
mkdir -p %{buildroot}/etc/cvmfs/keys
install -m 0444 REPO_NAME_REPLACE_ME.pub %{buildroot}/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.pub

mkdir -p %{buildroot}/etc/cvmfs/config.d
install -m 0444 REPO_NAME_REPLACE_ME.conf %{buildroot}/etc/cvmfs/config.d/REPO_NAME_REPLACE_ME.conf

%files
/etc/cvmfs/keys/REPO_NAME_REPLACE_ME.pub
/etc/cvmfs/config.d/REPO_NAME_REPLACE_ME.conf

%changelog