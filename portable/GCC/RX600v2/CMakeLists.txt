###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX600 for Renesas
###############################################################################

freertos_define_port(
    NAME freertos_port_renesas_rx600_v2
    ALIAS GCC_RX600_V2
    HEADERS
        portmacro.h
    SOURCES
        port.c )
