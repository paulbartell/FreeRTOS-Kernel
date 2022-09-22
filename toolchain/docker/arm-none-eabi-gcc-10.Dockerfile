# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
ARG TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2"
ARG TOOLCHAIN_ARCHIVE="gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2"
ARG TOOLCHAIN_DIR="gcc-arm-none-eabi-10.3-2021.10"
ARG TOOLCHAIN_VERSION="10.3-2021.10"

RUN wget ${TOOLCHAIN_URL} && \
    mkdir -p /opt && \
    tar -xvf ${TOOLCHAIN_ARCHIVE} -C /opt/ && \
    rm ${TOOLCHAIN_ARCHIVE} && \
    mv /opt/${TOOLCHAIN_DIR} /opt/gcc-arm-${TOOLCHAIN_VERSION}

ENV PATH=/opt/gcc-arm-${TOOLCHAIN_VERSION}/bin:$PATH
