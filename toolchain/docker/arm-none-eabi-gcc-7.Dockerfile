# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
ARG TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2"
ARG TOOLCHAIN_ARCHIVE="gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2"
ARG TOOLCHAIN_DIR="gcc-arm-none-eabi-7-2018-q2-update"
ARG TOOLCHAIN_VERSION="7-2018q2"

RUN wget ${TOOLCHAIN_URL} && \
    mkdir -p /opt && \
    tar -xvf ${TOOLCHAIN_ARCHIVE} -C /opt/ && \
    rm ${TOOLCHAIN_ARCHIVE} && \
    mv /opt/${TOOLCHAIN_DIR} /opt/gcc-arm-${TOOLCHAIN_VERSION}

ENV PATH=/opt/gcc-arm-${TOOLCHAIN_VERSION}/bin:$PATH
