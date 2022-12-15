###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

list(FIND gcc_arm_allowed_march_options "armv6-m" index)
if(NOT index EQUAL -1)

macro(define_arch_variant arch_variant_name )
    add_library( ${arch_variant_name} INTERFACE )

    target_compile_options( ${arch_variant_name}
                            INTERFACE
                                "-march=armv6-m"
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
# Define ARMv6-M architecture variants
###############################################################################
define_arch_variant( armv6m )

define_cpu_variant( cortex_m0
                    "-mcpu=cortex-m0" )

define_cpu_variant( cortex_m0plus
                    "-mcpu=cortex-m0plus" )

define_cpu_variant( cortex_m1
                    "-mcpu=cortex-m1" )

###############################################################################
# ARMv6M
###############################################################################
if(TARGET freertos_port_armv6m)
    # Generic ARMv6-M
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv6m
                              armv6m )

    # Cortex-M0
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv6m
                              cortex_m0 )

    # Cortex-M0+
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv6m
                              cortex_m0plus )

    # Cortex-M1
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv6m
                              cortex_m1 )
endif()

endif() # if(NOT index EQUAL -1)
