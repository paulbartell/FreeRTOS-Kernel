###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7-M MPU
###############################################################################

freertos_define_port(
    NAME freertos_port_armv7m_mpu
    ALIAS
        ARMv7-M+MPU
        Cortex-M3+MPU
        GCC_ARM_CM3_MPU
    HEADERS
        portmacro.h
    SOURCES
        port.c
        ${CMAKE_CURRENT_SOURCE_DIR}../../../Common/mpu_wrappers.c )
