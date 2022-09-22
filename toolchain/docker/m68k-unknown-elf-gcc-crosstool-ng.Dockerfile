# syntax=docker/dockerfile:1
FROM freertoskernelci/crosstool-ng:latest
RUN cd /opt/crosstool-ng && ./ct-ng m68k-unknown-elf
RUN cd /opt/crosstool-ng && ./ct-ng build