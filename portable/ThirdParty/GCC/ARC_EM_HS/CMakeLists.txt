###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARC_EM_HS
###############################################################################

freertos_define_port(
    NAME freertos_port_arc_em_hs
    ALIAS GCC_ARC_EM_HS
    HEADERS
        arc_freertos_exceptions.h
        portmacro.h
    SOURCES
        arc_support.s
        arc_freertos_exceptions.c
        freertos_tls.c
        port.c
)
