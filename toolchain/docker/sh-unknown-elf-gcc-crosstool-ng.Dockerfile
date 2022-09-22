# syntax=docker/dockerfile:1
FROM freertoskernelci/crosstool-ng:latest
RUN cd /opt/crosstool-ng && ./ct-ng sh-unknown-elf
RUN cd /opt/crosstool-ng && ./ct-ng build