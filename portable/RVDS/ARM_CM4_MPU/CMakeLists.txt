###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM_CM4_MPU port for RVDS
###############################################################################

freertos_define_port(
    NAME freertos_port_rvds_arm_cm4_mpu
    ALIAS RVDS_ARM_CM4_MPU
    HEADERS
        portmacro.h
    SOURCES
        port.c
        # TODO: is this relative path correct?
        ${CMAKE_CURRENT_SOURCE_DIR}../../../Common/mpu_wrappers.c
)
