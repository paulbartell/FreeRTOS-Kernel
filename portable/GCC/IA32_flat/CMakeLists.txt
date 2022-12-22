###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# GCC IA32 FLAT
###############################################################################

freertos_define_port(
    NAME freertos_port_ia32_flat
    ALIAS GCC_IA32_FLAT
    HEADERS
        portmacro.h
        ISR_Support.h
    SOURCES
        port.c
        portASM.S )
