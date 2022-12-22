###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# GCC CORTUS APS3
###############################################################################

freertos_define_port( 
    NAME cortus_aps3
    ALIAS GCC_CORTUS_APS3
    HEADERS
        portmacro.h
    SOURCES
        port.c )
