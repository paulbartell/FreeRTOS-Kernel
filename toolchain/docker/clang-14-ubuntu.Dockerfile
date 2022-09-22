# syntax=docker/dockerfile:1
FROM freertoskernelci/base:latest

RUN apt-get -y update && \
    apt-get install -y git python3.10-minimal python3.10 && \
    apt-get install -y clang-14 llvm-14  \
        libnewlib-arm-none-eabi avr-libc && \
    apt-get clean