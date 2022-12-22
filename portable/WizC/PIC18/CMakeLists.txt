###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# WizC PIC18 Port
###############################################################################

freertos_define_port(
    NAME freertos_port_wizc_pic18
    ALIAS
        WIZC_PIC18
    HEADERS
        portmacro.h
    SOURCES
        port.c
        Drivers/Tick/isrTick.c
        Drivers/Tick/Tick.c )
