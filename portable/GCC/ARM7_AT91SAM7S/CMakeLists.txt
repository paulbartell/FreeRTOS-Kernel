###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM7 AT91SAM7S
###############################################################################

freertos_define_port( 
    NAME freertos_port_arm7_at915am7s
    ALIAS GCC_ARM7_AT91SAM7S
    HEADERS
        portmacro.h
        ioat91sam7x256.h
        lib_AT91SAM7X256.h
    SOURCES
        port.c 
        portISR.c
        lib_AT91SAM7X256.c )
