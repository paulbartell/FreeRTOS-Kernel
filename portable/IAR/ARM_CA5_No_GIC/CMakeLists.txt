###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CA5 No GIC for IAR
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_ca5_no_gic
    ALIAS IAR_ARM_CA5_NOGIC
    HEADERS
        portmacro.h
        portASM.h
    SOURCES
        port.c
        portASM.s )
