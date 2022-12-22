###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# GCC STR75X
###############################################################################

freertos_define_port( 
    NAME freertos_port_str75x
    ALIAS GCC_STR75X
    HEADERS
        portmacro.h
    SOURCES
        port.c 
        portISR.c )
