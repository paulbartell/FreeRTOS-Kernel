###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX200 for Renesas
###############################################################################

freertos_define_port(
    NAME freertos_port_renesas_rx200
    ALIAS GCC_RX200
    HEADERS
        portmacro.h
    SOURCES
        port.c )
