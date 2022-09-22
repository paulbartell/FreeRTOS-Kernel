#!/bin/bash
docker build -f ubuntu-latest-base.Dockerfile . -t ffreertoskernelci/base:latest
docker build -f arm-none-eabi-gcc-4-6.Dockerfile . -t freertoskernelci/gcc-arm-4-6
docker build -f arm-none-eabi-gcc-4-7.Dockerfile . -t freertoskernelci/gcc-arm-4-7
docker build -f arm-none-eabi-gcc-4-8.Dockerfile . -t freertoskernelci/gcc-arm-4-8
docker build -f arm-none-eabi-gcc-4-9.Dockerfile . -t freertoskernelci/gcc-arm-4-9
docker build -f arm-none-eabi-gcc-5.Dockerfile . -t freertoskernelci/gcc-arm-5
docker build -f arm-none-eabi-gcc-6.Dockerfile . -t freertoskernelci/gcc-arm-6
docker build -f arm-none-eabi-gcc-7.Dockerfile . -t freertoskernelci/gcc-arm-7
docker build -f arm-none-eabi-gcc-8.Dockerfile . -t freertoskernelci/gcc-arm-8
docker build -f arm-none-eabi-gcc-9.Dockerfile . -t freertoskernelci/gcc-arm-9
docker build -f arm-none-eabi-gcc-10.Dockerfile . -t freertoskernelci/gcc-arm-10
docker build -f arm-none-eabi-gcc-11.Dockerfile . -t freertoskernelci/gcc-arm-11
docker build -f arm-none-eabi-gcc-ubuntu.Dockerfile . -t freertoskernelci/gcc-arm-ubuntu

docker build -f avr-gcc-5.4-ubuntu.Dockerfile . -t freertoskernelci/avr-gcc-5.4-ubuntu
docker build -f avr-gcc-5.4.0_atmel-3.6.2.1778.Dockerfile . -t freertoskernelci/avr-gcc-5.4.0_atmel-3.6.2.1778
docker build -f avr-gcc-7.3.0_atmel-3.7.0.1796.Dockerfile . -t freertoskernelci/avr-gcc-7.3.0_atmel-3.7.0.1796

# Crosstool