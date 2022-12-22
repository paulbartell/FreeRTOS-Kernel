###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM7 LPC2000
###############################################################################

freertos_define_port( 
    NAME freertos_port_arm7_lpc2000
    ALIAS GCC_ARM7_LPC2000
    HEADERS
        portmacro.h
    SOURCES
        port.c 
        portISR.c )
