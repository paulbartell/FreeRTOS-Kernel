###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7-R Port for CCS
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_cr4
    ALIAS
        ARMv7-R
        Cortex-R4
        CCS_ARM_CR4
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portASM.asm )
