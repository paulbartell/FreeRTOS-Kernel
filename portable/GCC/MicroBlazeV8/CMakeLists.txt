###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# MicroBlaze V8
###############################################################################

freertos_define_port(
    NAME freertos_port_microblaze_v8
    ALIAS GCC_MICROBLAZE_V8
    HEADERS
        portmacro.h
    SOURCES
        port.c
        port_exceptions.c
        portasm.S )
