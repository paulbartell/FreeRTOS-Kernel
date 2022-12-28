###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7E-M Port for Cortex-M7 r0p1
###############################################################################

freertos_define_port(
    NAME freertos_port_armv7em_cortex_m7_r0p1
    ALIAS
        Cortex-M7-r0p1
        GCC_ARM_CM7
    HEADERS
        portmacro.h
    SOURCES
        port.c )
