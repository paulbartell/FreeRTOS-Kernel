###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# PIC32MX
###############################################################################

freertos_define_port(
    NAME freertos_port_pic32mx
    ALIAS MPLAB_PIC32MX
    HEADERS
        ISR_Support.h
        portmacro.h
    SOURCES
        port_asm.S
        port.c
 )

