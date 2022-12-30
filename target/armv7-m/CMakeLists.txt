###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

macro(define_arch_variant arch_variant )
    define_variant_if_compiles( ${arch_variant} FLAGS -march=armv7-m -mthumb )
endmacro()

macro(define_cpu_variant arch_variant cpu_opt )
    define_variant_if_compiles( ${arch_variant} FLAGS ${cpu_opt} -mthumb )
endmacro()

###############################################################################
# Define ARMv7-M architecture variants
###############################################################################
define_arch_variant( armv7m )

define_cpu_variant( arm_cm3
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
                              arm_cm3 )
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
                              arm_cm3 )
endif()
