###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RL78 for IAR
###############################################################################

freertos_define_port(
    NAME freertos_port_rl78
    ALIAS IAR_RL78
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portasm.s )
