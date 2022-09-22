# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
ARG TOOLCHAIN_URL="https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/SoftwareLibraries/Firmware/avr8-gnu-toolchain-3.6.2.1778-linux.any.x86_64.tar.gz"
ARG TOOLCHAIN_ARCHIVE="avr8-gnu-toolchain-3.6.2.1778-linux.any.x86_64.tar.gz"
ARG TOOLCHAIN_DIR="avr8-gnu-toolchain-linux_x86_64"
ARG TOOLCHAIN_VERSION="5.4.0_atmel-3.6.2.1778"
ARG TOOLCHAIN_GCC_VERSION="5.4.0"

RUN wget ${TOOLCHAIN_URL} && \
    mkdir -p /opt && \
    tar -xvf ${TOOLCHAIN_ARCHIVE} -C /opt/ && \
    rm ${TOOLCHAIN_ARCHIVE} && \
    mv /opt/${TOOLCHAIN_DIR} /opt/avr-gcc-${TOOLCHAIN_VERSION}

ENV PATH=/opt/avr-gcc-${TOOLCHAIN_VERSION}/bin:$PATH

COPY avr-gcc-install-packs.sh /tmp/
RUN bash /tmp/avr-gcc-install-packs.sh \
    /opt/avr-gcc-${TOOLCHAIN_VERSION}/avr \
    /opt/avr-gcc-${TOOLCHAIN_VERSION}/lib/gcc/avr/${TOOLCHAIN_GCC_VERSION}/device-specs && \
    rm /tmp/avr-gcc-install-packs.sh