###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# AVR Mega0
###############################################################################

freertos_define_port(
    NAME freertos_port_avr_mega0
    ALIAS  IAR_AVR_MEGA0
    HEADERS
        portmacro.h
        porthardware.h
    SOURCES
        port.c
        portmacro.s90 )
