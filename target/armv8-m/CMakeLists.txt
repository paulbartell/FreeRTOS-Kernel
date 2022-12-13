###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

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
    add_library( ${arch_variant_name} INTERFACE )

    target_compile_options( ${arch_variant_name}
                            INTERFACE
                                ${cpu_opt}
                                "-mthumb"
                                ${float_abi_opt}
                                ${fpu_opt} )
endmacro()

###############################################################################
# ARMv8-M Base / Cortex-M23
###############################################################################
define_arch_variant( armv8m_base
                     "-march=armv8-m.base"
                     "-mfloat-abi=soft"
                     "" )

define_cpu_fp_variant( cortex_m23
                       "-mcpu=cortex-m23"
                       "-mfloat-abi=soft"
                       "" )

if(TARGET freertos_port_armv8m_base_ns)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU OFF)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_base_ns
                              armv8m_base )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_base_ns
                              cortex_m23 )
endif()


if(TARGET freertos_port_armv8m_base_ntz)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU OFF)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_base_ntz
                              armv8m_base )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_base_ntz
                              cortex_m23 )
endif()

###############################################################################
# ARMv8-M Base / Cortex-M23 MPU
###############################################################################
if(TARGET freertos_port_armv8m_base_ns)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU ON)

    # set(configTOTAL_MPU_REGIONS 4)

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_base_ns
    #                           armv8m_base )

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_base_ns
    #                           cortex_m23 )

    set(configTOTAL_MPU_REGIONS 8)

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_base_ns
                              armv8m_base )

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_base_ns
                              cortex_m23 )

    # set(configTOTAL_MPU_REGIONS 12)

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_base_ns
    #                           armv8m_base )

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_base_ns
    #                           cortex_m23 )

    # set(configTOTAL_MPU_REGIONS 16)

    # add_static_kernel_target( freertos_kernel_mpu16_ns
    #                           freertos_port_armv8m_base_ns
    #                           armv8m_base )

    # add_static_kernel_target( freertos_kernel_mpu16_ns
    #                           freertos_port_armv8m_base_ns
    #                           cortex_m23 )
endif()

if(TARGET freertos_port_armv8m_base_ntz)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU ON)

    # set(configTOTAL_MPU_REGIONS 4)

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_base_ntz
    #                           armv8m_base )

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_base_ntz
    #                           cortex_m23 )

    set(configTOTAL_MPU_REGIONS 8)

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_base_ntz
                              armv8m_base )

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_base_ntz
                              cortex_m23 )

    # set(configTOTAL_MPU_REGIONS 12)

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_base_ntz
    #                           armv8m_base )

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_base_ntz
    #                           cortex_m23 )

    # set(configTOTAL_MPU_REGIONS 16)

    # add_static_kernel_target( freertos_kernel_mpu16_ntz
    #                           freertos_port_armv8m_base_ntz
    #                           armv8m_base )

    # add_static_kernel_target( freertos_kernel_mpu16_ntz
    #                           freertos_port_armv8m_base_ntz
    #                           cortex_m23 )
endif()

###############################################################################
# ARMv8-M Main
###############################################################################
define_arch_variant( armv8m_main_soft
                     "-march=armv8-m.main"
                     "-mfloat-abi=soft"
                     "" )

define_arch_variant( armv8m_main_softfp_fpv5_sp_d16
                     "-march=armv8-m.main"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8m_main_softfp_fpv5_d16
                     "-march=armv8-m.main"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv8m_main_hard_fpv5_sp_d16
                     "-march=armv8-m.main"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8m_main_hard_fpv5_d16
                     "-march=armv8-m.main"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

###############################################################################
# ARMv8-M Main NS
###############################################################################
if(TARGET freertos_port_armv8m_main_ns)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU OFF)
    set(configTOTAL_MPU_REGIONS 0)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_hard_fpv5_d16 )
endif()

###############################################################################
# ARMv8-M Main NTZ
###############################################################################
if(TARGET freertos_port_armv8m_main_ntz)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU OFF)
    set(configTOTAL_MPU_REGIONS 0)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_hard_fpv5_d16 )
endif()

###############################################################################
# ARMv8-M Main MPU NS
###############################################################################
if(TARGET freertos_port_armv8m_main_ns)
    set(configENABLE_MPU ON)
    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 4)

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_softfp_fpv5_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_hard_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_hard_fpv5_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 8)

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_hard_fpv5_d16 )

    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 12)

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_softfp_fpv5_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_hard_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           armv8m_main_hard_fpv5_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 16)

    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              armv8m_main_hard_fpv5_d16 )
endif()

###############################################################################
# ARMv8-M Main MPU NTZ
###############################################################################
if(TARGET freertos_port_armv8m_main_ntz)
    set(configENABLE_MPU ON)

    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 4)

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_softfp_fpv5_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_hard_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_hard_fpv5_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 8)

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_hard_fpv5_d16 )

    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 12)

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_softfp_fpv5_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_hard_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           armv8m_main_hard_fpv5_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 16)

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              armv8m_main_hard_fpv5_d16 )
endif()

###############################################################################
# ARM Cortex-M33
###############################################################################
define_cpu_fp_variant( cortex_m33_soft
                       "-mcpu=cortex-m33"
                       "-mfloat-abi=soft"
                       "" )

define_arch_variant( cortex_m33_softfp_fpv5_sp_d16
                       "-march=armv8-m.main"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-sp-d16" )

define_arch_variant( cortex_m33_hard_fpv5_sp_d16
                       "-march=armv8-m.main"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-sp-d16" )

###############################################################################
# ARM Cortex-M33 NS
###############################################################################
if(TARGET freertos_port_armv8m_main_ns)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU OFF)
    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARM Cortex-M33 NTZ
###############################################################################
if(TARGET freertos_port_armv8m_main_ntz)
    set(configENABLE_FPU OFF)
    set(configENABLE_MPU OFF)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARM Cortex-M33 NS MPU
###############################################################################
if(TARGET freertos_port_armv8m_main_ns)
    set(configENABLE_MPU ON)

    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 4)
    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           cortex_m33_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           cortex_m33_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ns
    #                           freertos_port_armv8m_main_ns
    #                           cortex_m33_hard_fpv5_sp_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 8)
    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_hard_fpv5_sp_d16 )

    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 12)
    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           cortex_m33_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           cortex_m33_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ns
    #                           freertos_port_armv8m_main_ns
    #                           cortex_m33_hard_fpv5_sp_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 16)
    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ns
                              freertos_port_armv8m_main_ns
                              cortex_m33_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARM Cortex-M33 NTZ MPU
###############################################################################
if(TARGET freertos_port_armv8m_base_ntz)
    set(configENABLE_MPU ON)
    set(configENABLE_MVE OFF)

    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 4)

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           cortex_m33_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           cortex_m33_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu4_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           cortex_m33_hard_fpv5_sp_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 8)

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu8_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_hard_fpv5_sp_d16 )

    # set(configENABLE_FPU OFF)
    # set(configTOTAL_MPU_REGIONS 12)

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           cortex_m33_soft )

    # set(configENABLE_FPU ON)

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           cortex_m33_softfp_fpv5_sp_d16 )

    # add_static_kernel_target( freertos_kernel_mpu12_ntz
    #                           freertos_port_armv8m_main_ntz
    #                           cortex_m33_hard_fpv5_sp_d16 )

    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 16)

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_mpu16_ntz
                              freertos_port_armv8m_main_ntz
                              cortex_m33_hard_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv8.1-M Main
###############################################################################
define_arch_variant( armv8_1m_main_soft
                     "-march=armv8.1-m.main"
                     "-mfloat-abi=soft"
                     "" )

define_arch_variant( armv8_1m_main_softfp_fpv5_sp_d16
                     "-march=armv8.1-m.main"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8_1m_main_softfp_fpv5_d16
                     "-march=armv8.1-m.main"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv8_1m_main_hard_fpv5_sp_d16
                     "-march=armv8.1-m.main"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8_1m_main_hard_fpv5_d16
                     "-march=armv8.1-m.main"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

if(TARGET freertos_port_armv8_1m_main_ns)
    set(configENABLE_MVE OFF)
    set(configENABLE_MPU OFF)
    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 0)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_hard_fpv5_d16 )
endif()

if(TARGET freertos_port_armv8_1m_main_ntz)
    set(configENABLE_MVE OFF)
    set(configENABLE_MPU OFF)
    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 0)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_soft )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_softfp_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_softfp_fpv5_d16 )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_hard_fpv5_sp_d16 )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_hard_fpv5_d16 )
endif()

###############################################################################
# ARMv8.1-M Main MVE
###############################################################################
define_arch_variant( armv8_1m_main_soft_mve
                     "-march=armv8.1-m.main+mve"
                     "-mfloat-abi=soft"
                     "" )

define_arch_variant( armv8_1m_main_softfp_fpv5_sp_d16_mve
                     "-march=armv8.1-m.main+mve"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8_1m_main_softfp_fpv5_d16_mve
                     "-march=armv8.1-m.main+mve"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv8_1m_main_hard_fpv5_sp_d16_mve
                     "-march=armv8.1-m.main+mve"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8_1m_main_hard_fpv5_d16_mve
                     "-march=armv8.1-m.main+mve"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

if(TARGET freertos_port_armv8_1m_main_ns)
    set(configENABLE_MVE ON)
    set(configENABLE_MPU OFF)
    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 0)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_soft_mve )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_softfp_fpv5_sp_d16_mve )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_softfp_fpv5_d16_mve )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_hard_fpv5_sp_d16_mve )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_hard_fpv5_d16_mve )
endif()

if(TARGET freertos_port_armv8_1m_main_ntz)
    set(configENABLE_MVE ON)
    set(configENABLE_MPU OFF)
    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 0)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_soft_mve )

    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_softfp_fpv5_sp_d16_mve )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_softfp_fpv5_d16_mve )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_hard_fpv5_sp_d16_mve )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_hard_fpv5_d16_mve )
endif()

###############################################################################
# ARMv8.1-M Main MVE.fp
###############################################################################
define_arch_variant( armv8_1m_main_softfp_fpv5_sp_d16_mve_fp
                     "-march=armv8.1-m.main+mve.fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8_1m_main_softfp_fpv5_d16_mve_fp
                     "-march=armv8.1-m.main+mve.fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv8_1m_main_hard_fpv5_sp_d16_mve_fp
                     "-march=armv8.1-m.main+mve.fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8_1m_main_hard_fpv5_d16_mve_fp
                     "-march=armv8.1-m.main+mve.fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )


if(TARGET freertos_port_armv8_1m_main_ns)
    set(configENABLE_MVE ON)
    set(configENABLE_MPU OFF)
    set(configTOTAL_MPU_REGIONS 0)
    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_softfp_fpv5_sp_d16_mve_fp )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_softfp_fpv5_d16_mve_fp )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_hard_fpv5_sp_d16_mve_fp )

    add_static_kernel_target( freertos_kernel_ns
                              freertos_port_armv8_1m_main_ns
                              armv8_1m_main_hard_fpv5_d16_mve_fp )
endif()

if(TARGET freertos_port_armv8_1m_main_ntz)
    set(configENABLE_MVE ON)
    set(configENABLE_MPU OFF)
    set(configTOTAL_MPU_REGIONS 0)
    set(configENABLE_FPU ON)

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_softfp_fpv5_sp_d16_mve_fp )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_softfp_fpv5_d16_mve_fp )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_hard_fpv5_sp_d16_mve_fp )

    add_static_kernel_target( freertos_kernel_ntz
                              freertos_port_armv8_1m_main_ntz
                              armv8_1m_main_hard_fpv5_d16_mve_fp )
endif()
###############################################################################
# ARMv8.1-M Main + MPU
###############################################################################

###############################################################################
# Cortex-M55
###############################################################################

###############################################################################
# Cortex-M55 MPU
###############################################################################

###############################################################################
# Cortex-M55 MVE
###############################################################################

###############################################################################
# Cortex-M55 MVE MPU
###############################################################################

###############################################################################
# Cortex-M55 MVE+FP
###############################################################################

###############################################################################
# Cortex-M55 MVE+FP MPU
###############################################################################

###############################################################################
# Cortex-M85
###############################################################################

###############################################################################
# Cortex-M85 MPU
###############################################################################

###############################################################################
# Cortex-M85 MVE
###############################################################################

###############################################################################
# Cortex-M85 MVE MPU
###############################################################################

###############################################################################
# Cortex-M85 MVE+FP
###############################################################################

###############################################################################
# Cortex-M85 MVE+FP MPU
###############################################################################