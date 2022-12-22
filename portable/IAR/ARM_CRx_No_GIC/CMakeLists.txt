###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM CRx No GIC
###############################################################################

freertos_define_port(
    NAME freertos_port_arm_crx_no_gic
    ALIAS IAR_ARM_CRX_NOGIC
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portASM.s )
