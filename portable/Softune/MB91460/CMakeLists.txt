###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# MB91460
###############################################################################

freertos_define_port(
    NAME freertos_port_mb91460
    ALIAS SOFTUNE_MB91460
    HEADERS
        portmacro.h
    SOURCES
        __STD_LIB_sbrk.c
        port.c )
