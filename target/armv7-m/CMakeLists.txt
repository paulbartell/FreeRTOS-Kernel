###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7-M
###############################################################################
if(TARGET freertos_port_armv7m)
    # Generic ARMv7-M
    add_static_kernel_target( freertos_kernel_armv7m freertos_port_armv7m )

    target_compile_options( freertos_kernel_armv7m
                            PUBLIC
                                "-march=armv7-m"
                                "-mthumb" )

    target_add_freertos_config( freertos_kernel_armv7m )

    # Cortex-M3
    add_static_kernel_target( freertos_kernel_cortex_m3 freertos_port_armv7m )

    target_compile_options( freertos_kernel_cortex_m3
                            PUBLIC
                                "-mcpu=cortex-m3"
                                "-mthumb" )

    target_add_freertos_config( freertos_kernel_cortex_m3 )
endif()

###############################################################################
# ARMv7-M + MPU
###############################################################################
if(TARGET freertos_port_armv7m_mpu)
    # Generic ARMv7-M +MPU
    add_static_kernel_target( freertos_kernel_armv7m_mpu freertos_port_armv7m_mpu )

    target_compile_options( freertos_kernel_armv7m_mpu
                            PUBLIC
                                "-march=armv7-m"
                                "-mthumb" )

    target_add_freertos_config( freertos_kernel_armv7m_mpu )

    # Cortex-M3 +MPU
    add_static_kernel_target( freertos_kernel_cortex_m3_mpu freertos_port_armv7m_mpu )

    target_compile_options( freertos_kernel_cortex_m3_mpu
                            PUBLIC
                                "-mcpu=cortex-m3"
                                "-mthumb" )

    target_add_freertos_config( freertos_kernel_cortex_m3_mpu )
endif()
