###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# RX700v3 with double-precision FPU
###############################################################################

freertos_define_port(
    NAME freertos_port_renesas_rx700v3_dpfpu
    ALIAS GCC_RX700_V3_DPFPU
    HEADERS
        portmacro.h
    SOURCES
        port.c )
