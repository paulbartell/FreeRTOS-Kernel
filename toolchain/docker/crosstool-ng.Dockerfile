# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
RUN apt-get -y update && \
    apt-get install -y git flex texinfo unzip help2man file gawk libtool-bin bison libncurses-dev && \
    apt-get clean

RUN mkdir -p /root/src
RUN git clone https://github.com/crosstool-ng/crosstool-ng /opt/crosstool-ng
RUN cd /opt/crosstool-ng && ./bootstrap
RUN cd /opt/crosstool-ng && ./configure --enable-local
RUN cd /opt/crosstool-ng && make
COPY crosstool-ng-allow-root.patch /opt/crosstool-ng/
RUN cd /opt/crosstool-ng && git apply crosstool-ng-allow-root.patch
