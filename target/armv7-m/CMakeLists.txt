###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

list(FIND gcc_arm_allowed_march_options "armv7-m" index)
if(NOT index EQUAL -1)

macro(define_arch_variant arch_variant_name )
    add_library( ${arch_variant_name} INTERFACE )

    target_compile_options( ${arch_variant_name}
                            INTERFACE
                                "-march=armv7-m"
                                "-mthumb" )
endmacro()

macro(define_cpu_variant arch_variant_name cpu_opt )
    gcc_is_flag_allowed( "${gcc_arm_allowed_mcpu_options}" ${cpu_opt} is_allowed )
    if(${is_allowed} EQUAL 1)
        add_library( ${arch_variant_name} INTERFACE )
    
        target_compile_options( ${arch_variant_name}
                                INTERFACE
                                    ${cpu_opt}
                                    "-mthumb" )
    endif()
endmacro()

###############################################################################
# Define ARMv7-M architecture variants
###############################################################################
define_arch_variant( armv7m )

define_cpu_variant( cortex_m3
                    "-mcpu=cortex-m3" )

###############################################################################
# ARMv7-M
###############################################################################
if(TARGET freertos_port_armv7m)
    # Generic ARMv7-M
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7m
                              armv7m )

    # Cortex-M3
    add_static_kernel_target( freertos_kernel
    freertos_port_armv7m
                              cortex_m3 )
endif()

###############################################################################
# ARMv7-M + MPU
###############################################################################
if(TARGET freertos_port_armv7m_mpu)
    # Generic ARMv7-M
    add_static_kernel_target( freertos_kernel_mpu
                              freertos_port_armv7m_mpu
                              armv7m )

    # Cortex-M3
    add_static_kernel_target( freertos_kernel_mpu
                              freertos_port_armv7m_mpu
                              cortex_m3 )
endif()

endif()  # if(NOT index EQUAL -1)