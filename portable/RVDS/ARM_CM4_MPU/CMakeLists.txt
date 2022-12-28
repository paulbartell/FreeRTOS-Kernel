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
        port.c )

target_link_libraries(freertos_port_rvds_arm_cm4_mpu INTERFACE FreeRTOS::Kernel::Port::Common::MPU )
