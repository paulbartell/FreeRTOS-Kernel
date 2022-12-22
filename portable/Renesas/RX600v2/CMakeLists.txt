###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX600v2
###############################################################################

freertos_define_port(
    NAME freertos_port_rx600_v2
    ALIAS RENESAS_RX600_V2
    HEADERS
        portmacro.h
    SOURCES
        port_asm.src
        port.c
)
