###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# GCC MSP430F449
###############################################################################

freertos_define_port( 
    NAME freertos_port_msp430f449
    ALIAS GCC_MSP430F449
    HEADERS
        portmacro.h
    SOURCES
        port.c )
