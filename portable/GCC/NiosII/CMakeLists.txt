###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# NIOSII
###############################################################################

freertos_define_port(
    NAME freertos_port_nios2
    ALIAS GCC_NIOSII
    HEADERS
        portmacro.h
    SOURCES
        port.c
        port_asm.S )
