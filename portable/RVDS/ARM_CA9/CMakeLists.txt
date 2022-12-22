###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CA9 port for RVDS
###############################################################################

freertos_define_port(
    NAME freertos_port_rvds_arm_ca9
    ALIAS RVDS_ARM_CA9
    HEADERS
        portmacro.h
        portmacro.inc
    SOURCES
        portASM.s
        port.c
)
