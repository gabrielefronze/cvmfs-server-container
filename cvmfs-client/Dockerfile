FROM centos/systemd

MAINTAINER Gabriele Gaetano Fronzé "gfronze@cern.ch"

RUN yum update -y && yum -y install nano wget

RUN wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
RUN yum install -y cvmfs-release-latest.noarch.rpm
RUN rm -rf cvmfs-release-latest.noarch.rpm
RUN yum install -y cvmfs cvmfs-config-default

RUN mkdir /etc/cvmfs-init-scripts
COPY client-init.sh /etc/cvmfs-init-scripts

VOLUME [ “/sys/fs/cgroup” ]
CMD ["/usr/sbin/init"]
