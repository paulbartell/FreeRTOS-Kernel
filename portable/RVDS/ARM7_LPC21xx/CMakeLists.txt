###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7 LPC21XX for RVDS
###############################################################################

freertos_define_port(
    NAME freertos_port_arm7_lpc21xx
    ALIAS RVDS_ARM7_LPC21XX
    HEADERS
        portmacro.h
        portmacro.inc
    SOURCES
        portASM.s
        port.c )
