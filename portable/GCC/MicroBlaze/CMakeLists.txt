###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# MicroBlaze
###############################################################################

freertos_define_port(
    NAME freertos_port_microblaze
    ALIAS GCC_MICROBLAZE
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portasm.s )
