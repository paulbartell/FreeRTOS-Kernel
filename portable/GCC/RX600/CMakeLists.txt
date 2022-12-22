###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX600
###############################################################################

freertos_define_port(
    NAME freertos_port_renesas_rx600
    ALIAS GCC_RX600 
    HEADERS
        portmacro.h
    SOURCES
        port.c )
