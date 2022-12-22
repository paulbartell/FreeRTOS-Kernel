###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7E-M MPU
###############################################################################

freertos_define_port(
    NAME freertos_port_armv7em_mpu
    ALIAS
        ARMv7E-M+MPU
        Cortex-M4+MPU
        Cortex-M7+MPU
        GCC_ARM_CM4_MPU
    HEADERS
        portmacro.h
    SOURCES
        port.c
        ${CMAKE_CURRENT_SOURCE_DIR}../../../Common/mpu_wrappers.c )
