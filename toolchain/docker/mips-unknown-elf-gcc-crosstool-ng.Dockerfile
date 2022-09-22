# syntax=docker/dockerfile:1
FROM freertoskernelci/crosstool-ng:latest
RUN cd /opt/crosstool-ng && ./ct-ng mips-unknown-elf-gcc
RUN cd /opt/crosstool-ng && ./ct-ng build