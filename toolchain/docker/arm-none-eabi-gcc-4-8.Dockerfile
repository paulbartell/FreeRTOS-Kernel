# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
ARG TOOLCHAIN_URL="https://launchpad.net/gcc-arm-embedded/4.8/4.8-2014-q3-update/+download/gcc-arm-none-eabi-4_8-2014q3-20140805-linux.tar.bz2"
ARG TOOLCHAIN_ARCHIVE="gcc-arm-none-eabi-4_8-2014q3-20140805-linux.tar.bz2"
ARG TOOLCHAIN_DIR="gcc-arm-none-eabi-4_8-2014q3"
ARG TOOLCHAIN_VERSION="4_8-2014q3"

RUN wget ${TOOLCHAIN_URL} && \
    mkdir -p /opt && \
    tar -xvf ${TOOLCHAIN_ARCHIVE} -C /opt/ && \
    rm ${TOOLCHAIN_ARCHIVE} && \
    mv /opt/${TOOLCHAIN_DIR} /opt/gcc-arm-${TOOLCHAIN_VERSION}

ENV PATH=/opt/gcc-arm-${TOOLCHAIN_VERSION}/bin:$PATH
