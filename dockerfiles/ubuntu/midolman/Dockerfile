# Dockerfile to build midolman rc version for ubuntu
FROM ubuntu:14.04
MAINTAINER Jaume Devesa "jaume@midokura.com"

# Add the apt configuration file
ADD midolman_1.8.4_all.deb /opt/midolman.deb

ADD conf/midonet.list /etc/apt/sources.list.d/midonet.list
RUN apt-get install -qqy curl
RUN curl -k http://repo.midonet.org/packages.midokura.key | apt-key add -
RUN apt-get update -y
RUN apt-get install -y quagga bridge-utils haproxy iproute openjdk-7-jre-headless openvswitch-datapath-dkms=1.10.2-0ubuntu1 python uuid-runtime
RUN dpkg -i /opt/midolman.deb

ADD midolman.conf /etc/midolman/midolman.conf
ADD logback.xml /etc/midolman/logback.xml
ADD midolman-env.sh /etc/midolman/midolman-env.sh

# Add init script
ADD run_midolman.sh /opt/run_midolman.sh

# Run midolman by default
CMD /opt/run_midolman.sh
