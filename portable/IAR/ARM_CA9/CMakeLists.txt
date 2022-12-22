###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CA9 for IAR
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_ca9
    ALIAS IAR_ARM_CA9
    HEADERS
        portmacro.h
        portASM.h
    SOURCES
        port.c
        portASM.s )
