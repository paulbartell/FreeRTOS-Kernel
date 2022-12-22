###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# GCC H8S2329
###############################################################################

freertos_define_port(
    NAME freertos_port_h8s2329
    ALIAS GCC_H8S2329
    HEADERS
        portmacro.h
    SOURCES
        port.c )
