###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# PIC18F
###############################################################################

freertos_define_port(
    NAME freertos_port_pic18f
    ALIAS MPLAB_PIC18F
    HEADERS
        portmacro.h
        stdio.h
    SOURCES
        port.c )
