# This Dockerfile was extracted from this GitHub repository https://github.com/slateci/container-osg-frontier-squid

FROM centos:7

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y yum-plugin-priorities && \
    rpm -Uvh http://mirror.grid.uchicago.edu/pub/osg/3.4/osg-3.4-el7-release-latest.rpm

RUN yum clean all && \
    yum update -y && \
    yum install -y frontier-squid && \
    systemctl enable frontier-squid

ADD squid.conf /etc/squid/squid.conf

EXPOSE 3128

CMD ["/app/entrypoint.sh"]