###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CA53 64 BIT
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_ca53_64_bit
    ALIAS
        GCC_ARM_CA53_64_BIT
        Cortex-A53
        ARMv8-A
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portASM.S )
