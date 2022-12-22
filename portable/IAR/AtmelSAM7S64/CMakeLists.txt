###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# AtmelSAM7s64 for AT91S
###############################################################################

freertos_define_port(
    NAME freertos_port_atmel_sam7s64
    ALIAS IAR_ATMEL_SAM7S64
    HEADERS
        portmacro.h
        ISR_Support.h
        AT91SAM7S64_inc.h
        AT91SAM7S128_inc.h
        AT91SAM7S256_inc.h
        AT91SAM7S64.h
        AT91SAM7S128.h
        AT91SAM7S256.h
        lib_AT91SAM7S64.h
        lib_AT91SAM7S128.h
        lib_AT91SAM7S256.h
    SOURCES
        port.c
        portmacro.s79 )
