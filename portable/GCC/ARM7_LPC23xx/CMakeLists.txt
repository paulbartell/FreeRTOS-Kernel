###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM7 LPC23xx
###############################################################################

freertos_define_port(
    NAME freertos_port_arm7_lpc23xx
    ALIAS GCC_ARM7_LPC23XX
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portISR.c )
