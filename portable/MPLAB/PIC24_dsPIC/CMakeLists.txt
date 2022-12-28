###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# PIC24_dsPIC
###############################################################################

freertos_define_port(
    NAME freertos_port_pic24_dspic
    ALIAS MPLAB_PIC24
    HEADERS
        portmacro.h
    SOURCES
        portasm_PIC24.S
        portasm_dsPIC.S
        port.c )
