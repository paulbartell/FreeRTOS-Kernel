###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM7 AT91FR40008
###############################################################################

freertos_define_port( 
    NAME freertos_port_arm7_at91fr40008
    ALIAS GCC_ARM7_AT91FR40008
    HEADERS
        portmacro.h
    SOURCES
        port.c 
        portISR.c )
