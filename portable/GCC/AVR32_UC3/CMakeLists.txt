###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Microchip (Atmel) AVR32 UC3
###############################################################################

freertos_define_port(
    NAME freertos_port_avr32_uc3
    ALIAS GCC_AVR32_UC3
    HEADERS
        portmacro.h
    SOURCES
        port.c
        exception.S )
