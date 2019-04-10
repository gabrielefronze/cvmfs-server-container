# This file is subject to the terms and conditions defined by
# the LICENSE.md file and was developed by
# Gabriele Gaetano Fronzé, Sara Vallero and Stefano Lusso from
# INFN sezione Torino (IT).
# For abuse reports and other communications write to 
# <gabriele.fronze at to.infn.it>

FROM slidspitfire/cvmfs-server-base:latest

USER root
ENV USER root
ENV HOME /root

RUN wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-gateway-0.3.1/cvmfs-gateway-0.3.1-1.el7.x86_64.rpm
RUN yum install -y yum install cvmfs-gateway-0.3.1-1.el7.x86_64.rpm
RUN rm -rf yum install cvmfs-gateway-0.3.1-1.el7.x86_64.rpm

RUN systemctl start cvmfs-gateway.service
RUN systemctl enable cvmfs-gateway.service

EXPOSE 80
EXPOSE 4929

CMD ["/usr/sbin/init"]
