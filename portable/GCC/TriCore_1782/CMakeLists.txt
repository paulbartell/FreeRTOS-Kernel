###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# YOUR PORT
###############################################################################

freertos_define_port(
    NAME freertos_port_tricore_1782
    ALIAS GCC_TRICORE_1782
    HEADERS
        portmacro.h
    SOURCES
        port.c
        porttrap.c )
