###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# GCC ARC_v1
###############################################################################

freertos_define_port(
    NAME freertos_port_arc_v1
    ALIAS GCC_ARC_V1
    HEADERS
        arc_freertos_exceptions.h
        portmacro.h
    SOURCES
        arc_support.s
        arc_freertos_exceptions.c
        port.c
)
