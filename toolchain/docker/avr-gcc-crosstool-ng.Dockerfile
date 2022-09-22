# syntax=docker/dockerfile:1
FROM freertoskernelci/crosstool-ng:latest
RUN cd /opt/crosstool-ng && ./ct-ng avr
# RUN cd /opt/crosstool-ng && ./ct-ng build