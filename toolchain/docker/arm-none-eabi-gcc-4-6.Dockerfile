# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
ARG TOOLCHAIN_URL="https://launchpad.net/gcc-arm-embedded/4.6/4.6-2012-q4-update/+download/gcc-arm-none-eabi-4_6-2012q4-20121016.tar.bz2"
ARG TOOLCHAIN_ARCHIVE="gcc-arm-none-eabi-4_6-2012q4-20121016.tar.bz2"
ARG TOOLCHAIN_DIR="gcc-arm-none-eabi-4_6-2012q4"
ARG TOOLCHAIN_VERSION="4_6-2012q4"

RUN wget ${TOOLCHAIN_URL} && \
    mkdir -p /opt && \
    tar -xvf ${TOOLCHAIN_ARCHIVE} -C /opt/ && \
    rm ${TOOLCHAIN_ARCHIVE} && \
    mv /opt/${TOOLCHAIN_DIR} /opt/gcc-arm-${TOOLCHAIN_VERSION}

ENV PATH=/opt/gcc-arm-${TOOLCHAIN_VERSION}/bin:$PATH
