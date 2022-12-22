###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ROWLEY MSP430F449
###############################################################################

freertos_define_port(
    NAME freertos_port_msp430f449
    ALIAS ROWLEY_MSP430F449
    HEADERS
        portmacro.h
        portasm.h
    SOURCES
        port.c
        portext.asm )
