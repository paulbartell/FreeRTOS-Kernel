###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RXv2
###############################################################################

freertos_define_port(
    NAME freertos_port_renesas_rxv2
    ALIAS IAR_RX_V2
    HEADERS
        portmacro.h
    SOURCES
        port.c
        port_asm.s )
