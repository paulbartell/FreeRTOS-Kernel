###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# HCS12
###############################################################################

freertos_define_port( 
    NAME freertos_port_m68h_hcs12
    ALIAS GCC_HCS12                
    HEADERS
        portmacro.h
    SOURCES
        port.c )
