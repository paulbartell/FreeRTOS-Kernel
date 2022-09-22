# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest

ARG TOOLCHAIN_GCC_VERSION="5.4.0"

RUN apt-get -y update && \
    apt-get install -y gcc-avr avr-libc && \
    apt-get clean

COPY avr-gcc-install-packs.sh /tmp/
RUN bash /tmp/avr-gcc-install-packs.sh \
    /lib/avr \
    /lib/gcc/avr/${TOOLCHAIN_GCC_VERSION}/device-specs && \
    rm /tmp/avr-gcc-install-packs.sh
