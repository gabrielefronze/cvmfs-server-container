Name:       cvmfs-REPO_NAME_REPLACE_ME-conf
Version:    1
Release:    1
Summary:    Configuration distribution package for REPO_NAME_REPLACE_ME CVMFS repository.
License:    GPL

%description
This RPM handles the distribution of the configuration file for the REPO_NAME_REPLACE_ME CVMFS repository.

%prep
# we have no source, so nothing here

%build
bash /root/RPM-stuff/echo-repo-conf.sh REPO_NAME_REPLACE_ME STRATUM1_FQN_REPLACE_ME PROXY_FQN_REPLACE_ME} > REPO_NAME_REPLACE_ME.conf

%install
mkdir -p %{buildroot}/etc/cvmfs/config.d
install -m 0444 REPO_NAME_REPLACE_ME.conf %{buildroot}/etc/cvmfs/config.d/REPO_NAME_REPLACE_ME.conf

%files
/etc/cvmfs/config.d/REPO_NAME_REPLACE_ME.conf

%changelog