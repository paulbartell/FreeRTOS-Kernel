###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Common Files for MPU Ports
###############################################################################

freertos_define_port(
    NAME freertos_port_mpu_common
    ALIAS Common::MPU
    COMMON_FILES
    SOURCES
    mpu_wrappers.c )

# target_link_libraries(<your_freertos_mpu_port> INTERFACE FreeRTOS::Kernel::Port::Common::MPU )
