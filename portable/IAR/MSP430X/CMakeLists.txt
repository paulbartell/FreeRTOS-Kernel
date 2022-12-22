###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# IAR MSP430X
###############################################################################

freertos_define_port(
    NAME freertos_port_msp430x
    ALIAS IAR_MSP430X
    HEADERS
        portmacro.h
        portasm.h
    SOURCES
        port.c
        portext.s43 )
