# syntax=docker/dockerfile:1
FROM freertoskernelci/crosstool-ng:latest
RUN cd /opt/crosstool-ng && ./ct-ng arm-picolibc-eabi
RUN cd /opt/crosstool-ng && ./ct-ng build