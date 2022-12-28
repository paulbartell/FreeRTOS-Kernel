###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM_CM4F for RDVS
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_cm4f
    ALIAS
        ARMv7E-M
        Cortex-M4
        Cortex-M7
        RDVS_ARM_CM4F
    HEADERS
        portmacro.h
    SOURCES
        port.c
)
