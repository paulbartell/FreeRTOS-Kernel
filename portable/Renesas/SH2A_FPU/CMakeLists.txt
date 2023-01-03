###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# SH2A+FPU port for Renesas
###############################################################################

freertos_define_port(
    NAME freertos_port_sh2a_fpu
    ALIAS RENESAS_SH2A_FPU
    HEADERS
        portmacro.h
        ISR_Support.inc
    SOURCES
        portasm.src
        port.c )
