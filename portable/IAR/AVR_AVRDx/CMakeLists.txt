###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# AVRDx for AVR IAR
###############################################################################

freertos_define_port(
    NAME freertos_port_avr_avrdx
    ALIAS  IAR_AVR_AVRDX
    HEADERS
        portmacro.h
        porthardware.h
    SOURCES
        port.c
        portmacro.s90 )
