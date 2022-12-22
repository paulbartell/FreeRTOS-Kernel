###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7-M Port
###############################################################################

freertos_define_port(
    NAME freertos_port_armv7m
    ALIAS
        ARMv7-M
        Cortex-M3
        IAR_ARM_CM3
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portasm.s )
