###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX600 port for Renesas
###############################################################################

freertos_define_port(
    NAME freertos_port_rx600
    ALIAS RENESAS_RX600
    HEADERS
        portmacro.h
    SOURCES
        port_asm.src
        port.c
)
