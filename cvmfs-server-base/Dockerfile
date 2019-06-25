# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

FROM centos/systemd

USER root
ENV USER root
ENV HOME /root

RUN yum update -y && yum -y install \
    man nano wget epel-release jq

RUN wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
RUN yum install -y cvmfs-release-latest.noarch.rpm
RUN rm -rf cvmfs-release-latest.noarch.rpm
RUN yum install -y cvmfs cvmfs-server
RUN echo "CVMFS_HTTP_PROXY=DIRECT" > /etc/cvmfs/default.local

RUN systemctl enable httpd.service
RUN sed '/Listen 80/ a Listen 8000' -i /etc/httpd/conf/httpd.conf
EXPOSE 8000

RUN mkdir /etc/cvmfs-scripts
COPY restore-repo.sh /etc/cvmfs-scripts
COPY cvmfs-httpd-conf.template /etc/cvmfs-scripts
COPY cvmfs-fstab.template /etc/cvmfs-scripts
RUN chmod +x /etc/cvmfs-scripts/restore-repo.sh

COPY systemd-timers/* /etc/systemd/system/

VOLUME [ “/sys/fs/cgroup” ]
CMD ["/usr/sbin/init"]
