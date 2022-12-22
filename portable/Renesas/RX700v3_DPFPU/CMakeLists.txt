###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX700v3_DPFPU port for Renesas
###############################################################################

freertos_define_port(
    NAME freertos_port_rx700v3_dpfpu
    ALIAS RENESAS_RX700_V3_DPFPU
    HEADERS
        portmacro.h
    SOURCES
        port_asm.src
        port.c
)
