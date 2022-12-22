###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RL78
###############################################################################

freertos_define_port(
    NAME freertos_port_rl78
    ALIAS GCC_RL78
    HEADERS
        portmacro.h
        isr_support.h
    SOURCES
        port.c
        portasm.S )
