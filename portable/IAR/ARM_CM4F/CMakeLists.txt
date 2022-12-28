###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7E-M Port
###############################################################################

freertos_define_port(
    NAME freertos_port_armv7em
    ALIAS
        ARMv7E-M
        Cortex-M4
        Cortex-M7
        IAR_ARM_CM4F
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portasm.s )
