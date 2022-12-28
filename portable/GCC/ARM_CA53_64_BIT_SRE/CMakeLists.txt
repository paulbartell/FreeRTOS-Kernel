###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CA53 64 BIT sre
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_ca53_64_bit_sre
    ALIAS
        GCC_ARM_CA53_64_BIT_SRE
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portASM.S )
