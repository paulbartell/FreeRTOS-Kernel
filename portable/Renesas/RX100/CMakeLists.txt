###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX100 port for Renesas
###############################################################################

freertos_define_port(
    NAME freertos_port_rx100
    ALIAS RENESAS_RX100
    HEADERS
        portmacro.h
    SOURCES
        port_asm.src
        port.c
)
