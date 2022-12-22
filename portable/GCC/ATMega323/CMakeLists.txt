###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ATMEGA323 for IAR
###############################################################################

freertos_define_port( 
    NAME freertos_port_atmega323
    ALIAS IAR_ATMEGA323
    HEADERS
        portmacro.h
    SOURCES
        port.c )
