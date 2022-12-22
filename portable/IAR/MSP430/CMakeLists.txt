###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# IAR MSP430
###############################################################################

freertos_define_port(
    NAME freertos_port_msp430
    ALIAS IAR_MSP430
    HEADERS
        portmacro.h
        portasm.h
    SOURCES
        port.c
        portext.s43 )
