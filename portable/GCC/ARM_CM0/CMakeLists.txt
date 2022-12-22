###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv6-M Port
###############################################################################

freertos_define_port(
    NAME freertos_port_armv6m
    ALIAS ARMv6-M Cortex-M0
    HEADERS
        portmacro.h
    SOURCES
        port.c )
