###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM_CM0
###############################################################################

freertos_define_port(
    NAME freertos_port_rvds_arm_cm0
    ALIAS RVDS_ARM_CM0
    HEADERS
        portmacro.h
    SOURCES
        port.c
)
