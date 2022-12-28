###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Cygnal port for SDCC
###############################################################################

freertos_define_port(
    NAME freertos_port_dcc_cygnal
    ALIAS SDCC_CYGNAL
    HEADERS
        portmacro.h
    SOURCES
        port.c )
