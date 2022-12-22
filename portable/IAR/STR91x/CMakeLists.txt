###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# IAR STR91x
###############################################################################

freertos_define_port(
    NAME freertos_port_str91x
    ALIAS IAR_STR91X
    HEADERS
        portmacro.h
        ISR_Support.h
    SOURCES
        port.c
        portasm.s79 )
