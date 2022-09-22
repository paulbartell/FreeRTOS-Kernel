# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest
RUN apt-get update -y && \
    apt-get install -y gcc-arm-none-eabi libnewlib-arm-none-eabi \
    && apt-get clean
