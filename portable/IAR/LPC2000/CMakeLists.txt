###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# IAR LPC2000
###############################################################################

freertos_define_port(
    NAME freertos_port_lpc2000
    ALIAS IAR_LPC2000
    HEADERS
        portmacro.h
        ISR_Support.h
    SOURCES
        port.c
        portasm.s79 )
