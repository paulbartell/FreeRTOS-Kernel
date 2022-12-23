###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CA9
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_ca9
    ALIAS GCC_ARM_CA9
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portASM.S )
