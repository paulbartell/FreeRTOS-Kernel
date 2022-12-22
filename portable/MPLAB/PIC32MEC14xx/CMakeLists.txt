###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# PIC32MEC14xx
###############################################################################

freertos_define_port(
    NAME freertos_port_pic32mec14xx
    ALIAS MPLAB_PIC32MEC14XX
    HEADERS
        ISR_Support.h
        portmacro.h
    SOURCES
        port_asm.S
        port.c
 )

