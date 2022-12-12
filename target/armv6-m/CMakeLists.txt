###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv6M
###############################################################################
if(TARGET freertos_port_armv6m)
    # Generic ARMv6-M
    add_static_kernel_target( freertos_kernel_armv6m freertos_port_armv6m )

    target_compile_options( freertos_kernel_armv6m
                            PUBLIC
                                "-march=armv6-m"
                                "-mthumb" )

    target_add_freertos_config( freertos_kernel_armv6m )

    add_library( FreeRTOS::Kernel::ARMv6-M ALIAS freertos_kernel_armv6m )

    # Cortex-M0
    add_static_kernel_target( freertos_kernel_cortex_m0 freertos_port_armv6m )

    target_compile_options( freertos_kernel_cortex_m0
                            PUBLIC
                                "-mcpu=cortex-m0"
                                "-mthumb" )

    target_add_freertos_config( freertos_kernel_cortex_m0 )

    add_library( FreeRTOS::Kernel::Cortex-M0 ALIAS freertos_kernel_cortex_m0 )

    # Cortex-M0+
    add_static_kernel_target( freertos_kernel_cortex_m0_plus freertos_port_armv6m )

    target_compile_options( freertos_kernel_cortex_m0_plus
                            PUBLIC
                                "-mcpu=cortex-m0plus"
                                "-mthumb" )

    target_add_freertos_config( freertos_kernel_cortex_m0_plus )

    add_library( FreeRTOS::Kernel::Cortex-M0+ ALIAS freertos_kernel_cortex_m0_plus )
endif()
