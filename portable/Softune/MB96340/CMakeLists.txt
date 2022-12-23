###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# MB96340 port for Softune
###############################################################################

freertos_define_port(
    NAME freertos_port_mb96340
    ALIAS SOFTUNE_MB96340
    HEADERS
        portmacro.h
    SOURCES
        __STD_LIB_sbrk.c
        port.c
)
