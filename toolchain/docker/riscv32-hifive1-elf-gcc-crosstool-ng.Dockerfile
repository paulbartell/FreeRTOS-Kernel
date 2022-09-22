# syntax=docker/dockerfile:1
FROM freertoskernelci/crosstool-ng:latest
RUN cd /opt/crosstool-ng && ./ct-ng riscv32-hifive1-elf
RUN cd /opt/crosstool-ng && ./ct-ng build