# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
RUN apt-get update -y && \
    apt-get install -y gcc-m68hc1x binutils-m68hc1x && \
    apt-get install -y debhelper autoconf && \
    apt-get clean

RUN cd /root && \
    wget http://old-releases.ubuntu.com/ubuntu/pool/universe/n/newlib-m68hc1x/newlib-m68hc1x_1.12.0+3.1-2.dsc \
         http://old-releases.ubuntu.com/ubuntu/pool/universe/n/newlib-m68hc1x/newlib-m68hc1x_1.12.0+3.1-2.diff.gz \
         http://old-releases.ubuntu.com/ubuntu/pool/universe/n/newlib-m68hc1x/newlib-m68hc1x_1.12.0+3.1.orig.tar.gz && \
    dpkg-source -x newlib-m68hc1x_1.12.0+3.1-2.dsc && \
    cd newlib-m68hc1x-1.12.0+3.1 && \
    echo 7 > debian/compat && \
    dpkg-buildpackage -rfakeroot -uc -us --jobs-try=auto --build=source,all && \
    cd /root && \
    rm -rf newlib-m68hc1x-1.12.0+3.1 && \
    dpkg -i newlib-m68hc1x_1.12.0+3.1-2_all.deb
