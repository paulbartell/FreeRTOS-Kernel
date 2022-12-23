###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CR5
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_cr5
    ALIAS GCC_ARM_CR5
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portASM.S )
