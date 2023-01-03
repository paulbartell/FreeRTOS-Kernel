###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ATmega
###############################################################################

freertos_define_port(
    NAME freertos_port_atmega
    ALIAS GCC_ATMEGA
    HEADERS
        portmacro.h
    SOURCES
        port.c )
