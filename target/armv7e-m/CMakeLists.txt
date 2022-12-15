###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

list(FIND gcc_arm_allowed_march_options "armv7e-m" index)
if(NOT index EQUAL -1)

macro(define_arch_fp_variant arch_variant_name float_abi_opt fpu_opt )
    add_library( ${arch_variant_name} INTERFACE )

    target_compile_options( ${arch_variant_name}
                            INTERFACE
                                "-march=armv7e-m"
                                "-mthumb"
                                ${float_abi_opt}
                                ${fpu_opt} )
endmacro()

macro(define_cpu_fp_variant arch_variant_name cpu_opt float_abi_opt fpu_opt )
    gcc_is_flag_allowed( "${gcc_arm_allowed_mcpu_options}" ${cpu_opt} is_allowed )
    if(${is_allowed} EQUAL 1)
        add_library( ${arch_variant_name} INTERFACE )

        target_compile_options( ${arch_variant_name}
                                INTERFACE
                                    ${cpu_opt}
                                    "-mthumb"
                                    ${float_abi_opt}
                                    ${fpu_opt} )
    endif()
endmacro()

###############################################################################
# Define ARMv7E-M architecture variants
###############################################################################
# Soft floating point
define_arch_fp_variant( armv7em_soft
                        "-mfloat-abi=soft"
                        "" )

# softfp ABI
define_arch_fp_variant( armv7em_softfp_fpv4_sp_d16
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv4-sp-d16" )

define_arch_fp_variant( armv7em_softfp_fpv5_d16
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv5-d16" )

define_arch_fp_variant( armv7em_softfp_fpv5_sp_d16
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv5-sp-d16" )

# hard fp ABI
define_arch_fp_variant( armv7em_hard_fpv4_sp_d16
                        "-mfloat-abi=hard"
                        "-mfpu=fpv4-sp-d16" )

define_arch_fp_variant( armv7em_hard_fpv5_d16
                        "-mfloat-abi=hard"
                        "-mfpu=fpv5-d16" )

define_arch_fp_variant( armv7em_hard_fpv5_sp_d16
                        "-mfloat-abi=hard"
                        "-mfpu=fpv5-sp-d16" )

# Cortex-M4
define_cpu_fp_variant( cortex_m4_soft
                        "-mcpu=cortex-m4"
                        "-mfloat-abi=soft"
                        "" )

define_cpu_fp_variant( cortex_m4_softfp_fpv4_sp_d16
                        "-mcpu=cortex-m4"
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv4-sp-d16" )

define_cpu_fp_variant( cortex_m4_hard_fpv4_sp_d16
                        "-mcpu=cortex-m4"
                        "-mfloat-abi=hard"
                        "-mfpu=fpv4-sp-d16" )

# Cortex-M7
define_cpu_fp_variant( cortex_m7_soft
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=soft"
                        "" )

define_cpu_fp_variant( cortex_m7_softfp_fpv5_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv5-d16" )

define_cpu_fp_variant( cortex_m7_softfp_fpv5_sp_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv5-sp-d16" )

define_cpu_fp_variant( cortex_m7_hard_fpv5_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=hard"
                        "-mfpu=fpv5-d16" )

define_cpu_fp_variant( cortex_m7_hard_fpv5_sp_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=hard"
                        "-mfpu=fpv5-sp-d16" )

# Cortex-M7 r0p1
define_cpu_fp_variant( cortex_m7_r0p1_soft
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=soft"
                        "" )

define_cpu_fp_variant( cortex_m7_r0p1_softfp_fpv5_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv5-d16" )

define_cpu_fp_variant( cortex_m7_r0p1_softfp_fpv5_sp_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=softfp"
                        "-mfpu=fpv5-sp-d16" )

define_cpu_fp_variant( cortex_m7_r0p1_hard_fpv5_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=hard"
                        "-mfpu=fpv5-d16" )

define_cpu_fp_variant( cortex_m7_r0p1_hard_fpv5_sp_d16
                        "-mcpu=cortex-m7"
                        "-mfloat-abi=hard"
                        "-mfpu=fpv5-sp-d16" )

###############################################################################
# Generic ARMv7E-M
###############################################################################
if(TARGET freertos_port_armv7em)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)

    # Generic ARMv7E-M
    # Note: Uses the Cortex-M3 port (ARMv7M rather than ARMv7E-M)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7m
                              armv7em_soft )

    # Generic ARMv7E-M with FPv4 Single Precision Soft FP ABI (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              armv7em_softfp_fpv4_sp_d16 )

    # Generic ARMv7E-M with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              armv7em_softfp_fpv5_d16 )

    # Generic ARMv7E-M with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              armv7em_softfp_fpv5_sp_d16 )

    # Generic ARMv7E-M with FPv4 Single Precision Hard FP ABI (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              armv7em_hard_fpv4_sp_d16 )

    # Generic ARMv7E-M with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              armv7em_hard_fpv5_d16 )

    # Generic ARMv7E-M with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              armv7em_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARM Cortex-M4
###############################################################################
if(TARGET freertos_port_armv7em)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)

    # Cortex-M4
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7m
                              cortex_m4_soft )

    # Cortex-M4 with FPv4 Single Precision Soft FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m4_softfp_fpv4_sp_d16 )

    # Cortex-M4 with FPv4 Single Precision Hard FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m4_hard_fpv4_sp_d16 )
endif()

###############################################################################
# ARM Cortex-M7
###############################################################################
if(TARGET freertos_port_armv7em)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)

    # Cortex-M7
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7m
                              cortex_m7_soft )

    # Cortex-M7 with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_softfp_fpv5_d16 )

    # Cortex-M7 with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_hard_fpv5_d16 )

    # Cortex-M7 with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_softfp_fpv5_sp_d16 )

    # Cortex-M7 with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 with r0p1 erratam
###############################################################################
if(TARGET freertos_port_armv7em_cortex_m7_r0p1)
    set(configENABLE_ERRATA_837070_WORKAROUND ON)

    # Cortex-M7 r0p1
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7m
                              cortex_m7_r0p1_soft )

    # Cortex-M7 r0p1 with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_r0p1_softfp_fpv5_d16 )

    # Cortex-M7 r0p1 with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_r0p1_hard_fpv5_d16 )

    # Cortex-M7 r0p1 with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_r0p1_softfp_fpv5_sp_d16 )

    # Cortex-M7 r0p1 with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel
                              freertos_port_armv7em
                              cortex_m7_r0p1_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Generic + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)
    set(configTOTAL_MPU_REGIONS 8)

    # Generic ARMv7E-M
    # Note: Uses the Cortex-M3 port (ARMv7M rather than ARMv7E-M)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7m_mpu
                              armv7em_soft )

    # Generic ARMv7E-M with FPv4 Single Precision Soft FP ABI (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              armv7em_softfp_fpv4_sp_d16 )

    # Generic ARMv7E-M with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              armv7em_softfp_fpv5_d16 )

    # Generic ARMv7E-M with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              armv7em_softfp_fpv5_sp_d16 )

    # Generic ARMv7E-M with FPv4 Single Precision Hard FP ABI (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              armv7em_hard_fpv4_sp_d16 )

    # Generic ARMv7E-M with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              armv7em_hard_fpv5_d16 )

    # Generic ARMv7E-M with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              armv7em_hard_fpv5_sp_d16 )

endif()

###############################################################################
# ARMv7E-M Generic + 16 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)
    set(configTOTAL_MPU_REGIONS 16)

    # Generic ARMv7E-M
    # Note: Uses the Cortex-M3 port (ARMv7M rather than ARMv7E-M)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7m_mpu
                              armv7em_soft )

    # Generic ARMv7E-M with FPv4 Single Precision Soft FP ABI (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              armv7em_softfp_fpv4_sp_d16 )

    # Generic ARMv7E-M with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              armv7em_softfp_fpv5_d16 )

    # Generic ARMv7E-M with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              armv7em_softfp_fpv5_sp_d16 )

    # Generic ARMv7E-M with FPv4 Single Precision Hard FP ABI (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              armv7em_hard_fpv4_sp_d16 )

    # Generic ARMv7E-M with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              armv7em_hard_fpv5_d16 )

    # Generic ARMv7E-M with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              armv7em_hard_fpv5_sp_d16 )

endif()

###############################################################################
# ARMv7E-M Cortex-M4 + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)
    set(configTOTAL_MPU_REGIONS 8)

    # Cortex-M4
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7m_mpu
                              cortex_m4_soft )

    # Cortex-M4 with FPv4 Single Precision Soft FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m4_softfp_fpv4_sp_d16 )

    # Cortex-M4 with FPv4 Single Precision Hard FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m4_hard_fpv4_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)
    set(configTOTAL_MPU_REGIONS 8)

    # Cortex-M7
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7m_mpu
                              cortex_m7_soft )

    # Cortex-M7 with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_softfp_fpv5_d16 )

    # Cortex-M7 with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_hard_fpv5_d16 )

    # Cortex-M7 with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_softfp_fpv5_sp_d16 )

    # Cortex-M7 with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 + 16 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)
    set(configTOTAL_MPU_REGIONS 16)

    # Cortex-M7
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7m_mpu
                              cortex_m7_soft )

    # Cortex-M7 with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_softfp_fpv5_d16 )

    # Cortex-M7 with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_hard_fpv5_d16 )

    # Cortex-M7 with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_softfp_fpv5_sp_d16 )

    # Cortex-M7 with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 r0p1 + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configENABLE_ERRATA_837070_WORKAROUND ON)
    set(configTOTAL_MPU_REGIONS 8)

    # Cortex-M7
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7m_mpu
                              cortex_m7_r0p1_soft )

    # Cortex-M7 with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_softfp_fpv5_d16 )

    # Cortex-M7 with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_hard_fpv5_d16 )

    # Cortex-M7 with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_softfp_fpv5_sp_d16 )

    # Cortex-M7 with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu8
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 r0p1 + 16 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configENABLE_ERRATA_837070_WORKAROUND ON)
    set(configTOTAL_MPU_REGIONS 16)

    # Cortex-M7
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7m_mpu
                              cortex_m7_r0p1_soft )

    # Cortex-M7 with FPv5 Double Precision Soft FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_softfp_fpv5_d16 )

    # Cortex-M7 with FPv5 Double Precision Hard FP ABI (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_hard_fpv5_d16 )

    # Cortex-M7 with FPv5 Single Precision Soft FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_softfp_fpv5_sp_d16 )

    # Cortex-M7 with FPv5 Single Precision Hard FP ABI (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_mpu16
                              freertos_port_armv7em_mpu
                              cortex_m7_r0p1_hard_fpv5_sp_d16 )
endif()

endif() # if(NOT index EQUAL -1)
