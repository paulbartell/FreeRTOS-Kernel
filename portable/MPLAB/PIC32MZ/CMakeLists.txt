###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# PIC32MZ
###############################################################################

freertos_define_port(
    NAME freertos_port_pic32mz
    ALIAS MPLAB_PIC32MZ
    HEADERS
        ISR_Support.h
        portmacro.h
    SOURCES
        port_asm.S
        port.c
 )

