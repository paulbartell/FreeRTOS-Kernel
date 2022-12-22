###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# IAR 78K0K
###############################################################################

freertos_define_port(
    NAME freertos_port_78k0k
    ALIAS IAR_78K0K
    HEADERS
        portmacro.h
        ISR_support.h
    SOURCES
        port.c
        portasm.s26 )
