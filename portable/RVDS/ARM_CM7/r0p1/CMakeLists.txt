###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM_CM7
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_cm7
    ALIAS
        RVDS_ARM_CM7
        Cortex-M7
    HEADERS
        portmacro.h
    SOURCES
        port.c )
