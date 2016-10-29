#
# Clear Linux Development Enviornment for Clear Containers
#

FROM clearlinux:latest

MAINTAINER Manohar Castelino "manohar.r.castelino@intel.com"

#Ensure that we update past format bumps
RUN swupd update -s && \
    swupd update

RUN swupd update -s && \
    swupd update

RUN swupd update -s && \
    swupd update

RUN swupd update -s && \
    swupd update
    
RUN swupd update -s && \
    swupd update

RUN swupd bundle-add os-core-dev os-dev-extras containers-basic

RUN rpm -ivh --nodeps --force https://download.clearlinux.org/current/x86_64/os/Packages/json-glib-dev-1.2.2-9.x86_64.rpm

RUN rpm -ivh --nodeps --force https://download.clearlinux.org/current/x86_64/os/Packages/libmnl-dev-1.0.4-9.x86_64.rpm

RUN mkdir -p /var/run/ && \
    mkdir -p /etc/docker/ && \
    mkdir -p /run/opencontainer/containers/

RUN git clone https://github.com/01org/cc-oci-runtime.git /cc-oci-runtime

RUN cd /cc-oci-runtime && \
    autoreconf -fvi && \
    bash autogen.sh --disable-cppcheck --disable-valgrind \
         --with-cc-kernel=/usr/share/clear-containers/vmlinux.container \
         --with-cc-image=/usr/share/clear-containers/clear-containers.img && \
    make && make install

RUN echo "dockerd --add-runtime cor=/usr/bin/cc-oci-runtime --default-runtime=cor --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --storage-driver=vfs &> /tmp/docker.log &" > /run_dockerd && chmod +x /run_dockerd

CMD ["/bin/bash"]
