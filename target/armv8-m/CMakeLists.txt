###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

macro(define_arch_fp_variant arch_variant float_abi_opt fpu_opt )
    add_library( ${arch_variant} INTERFACE )

    target_compile_options( ${arch_variant}
                            INTERFACE
                                "-march=armv7e-m"
                                "-mthumb"
                                ${float_abi_opt}
                                ${fpu_opt} )
endmacro()

macro(define_cpu_fp_variant arch_variant cpu_opt float_abi_opt fpu_opt )
    add_library( ${arch_variant} INTERFACE )

    target_compile_options( ${arch_variant}
                            INTERFACE
                                ${cpu_opt}
                                "-mthumb"
                                ${float_abi_opt}
                                ${fpu_opt} )
endmacro()

function(add_fr_config_variants target_suffix port arch_variant  )
    set(configENABLE_MVE OFF)
    set(configENABLE_MPU OFF)
    set(configENABLE_FPU OFF)
    set(configTOTAL_MPU_REGIONS 0)

    if(${arch_variant} MATCHES "_softfp" OR ${arch_variant} MATCHES "_hard")
        set(configENABLE_FPU ON)
    endif()

    if(${arch_variant} MATCHES "_mve")
        set(configENABLE_MVE ON)
    endif()

    # Non-MPU Target
    add_static_kernel2target( ${target_suffix}
                              ${port}
                              ${arch_variant} )

    set(configENABLE_MPU ON)

    # set(configTOTAL_MPU_REGIONS 4)
    # add_static_kernel2target( ${target_suffix}_mpu04
    #                           ${port}
    #                           ${arch_variant} )

    set(configTOTAL_MPU_REGIONS 8)
    add_static_kernel2target( ${target_suffix}_mpu08
                              ${port}
                              ${arch_variant} )

    # "main" cpu variants support up to 16 mpu regions
    if(${arch_variant} MATCHES "_main_" OR ${arch_variant} MATCHES "cortex_m(33|55|85)")
        # set(configTOTAL_MPU_REGIONS 12)
        # add_static_kernel2target( ${target_suffix}_mpu12
        #                           ${port}
        #                           ${arch_variant} )

        set(configTOTAL_MPU_REGIONS 16)
        add_static_kernel2target( ${target_suffix}_mpu16
                                  ${port}
                                  ${arch_variant} )
    endif()
endfunction()

###############################################################################
# ARMv8-M Base / Cortex-M23
###############################################################################
define_arch_variant( armv8m_base
                     "-march=armv8-m.base"
                     "-mfloat-abi=soft"
                     "" )

define_cpu_fp_variant( arm_cm23
                       "-mcpu=cortex-m23"
                       "-mfloat-abi=soft"
                       "" )

if(TARGET freertos_port_armv8m_base_ns)
    add_fr_config_variants( ns
                            freertos_port_armv8m_base_ns
                            armv8m_base )

    add_fr_config_variants( ns
                            freertos_port_armv8m_base_ns
                            arm_cm23 )
endif()


if(TARGET freertos_port_armv8m_base_ntz)
    add_fr_config_variants( ntz
                            freertos_port_armv8m_base_ntz
                            armv8m_base )

    add_fr_config_variants( ntz
                            freertos_port_armv8m_base_ntz
                            arm_cm23 )
endif()

###############################################################################
# ARMv8-M Main
###############################################################################
define_arch_variant( armv8m_main
                     "-march=armv8-m.main+nofp"
                     "-mfloat-abi=soft"
                     "" )

# Single Precision FP
define_arch_variant( armv8m_main_fpv5_sp_d16_softfp
                     "-march=armv8-m.main+fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv8m_main_fpv5_sp_d16_hard
                     "-march=armv8-m.main+fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

# Double Precision FP
define_arch_variant( armv8m_main_fpv5_d16_softfp
                     "-march=armv8-m.main+fp.dp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv8m_main_fpv5_d16_hard
                     "-march=armv8-m.main+fp.dp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

###############################################################################
# ARMv8-M Main NS
###############################################################################
if(TARGET freertos_port_armv8m_main_ns)
    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            armv8m_main )

    # Single Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            armv8m_main_fpv5_sp_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            armv8m_main_fpv5_sp_d16_hard )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            armv8m_main_fpv5_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            armv8m_main_fpv5_d16_hard )
endif()

###############################################################################
# ARMv8-M Main NTZ
###############################################################################
if(TARGET freertos_port_armv8m_main_ntz)
    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            armv8m_main )

    # Single Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            armv8m_main_fpv5_sp_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            armv8m_main_fpv5_sp_d16_hard )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            armv8m_main_fpv5_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            armv8m_main_fpv5_d16_hard )
endif()

###############################################################################
# ARM Cortex-M33
###############################################################################
define_cpu_fp_variant( arm_cm33
                       "-mcpu=cortex-m33+nofp"
                       "-mfloat-abi=soft"
                       "" )

define_cpu_fp_variant( arm_cm33_fpv5_sp_d16_softfp
                       "-mcpu=cortex-m33"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-sp-d16" )

define_cpu_fp_variant( arm_cm33_fpv5_sp_d16_hard
                       "-mcpu=cortex-m33"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-sp-d16" )

if(TARGET freertos_port_armv8m_main_ns)
    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            arm_cm33 )

    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            arm_cm33_fpv5_sp_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            arm_cm33_fpv5_sp_d16_hard )
endif()

if(TARGET freertos_port_armv8m_main_ntz)
    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ns
                            arm_cm33 )

    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            arm_cm33_fpv5_sp_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            arm_cm33_fpv5_sp_d16_hard )
endif()

###############################################################################
# ARM Cortex-M35P
###############################################################################
define_cpu_fp_variant( arm_cm35p
                       "-mcpu=cortex-m35p+nofp"
                       "-mfloat-abi=soft"
                       "" )

define_cpu_fp_variant( arm_cm35p_fpv5_sp_d16_softfp
                       "-mcpu=cortex-m35p"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-sp-d16" )

define_cpu_fp_variant( arm_cm35p_fpv5_sp_d16_hard
                       "-mcpu=cortex-m35p"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-sp-d16" )

if(TARGET freertos_port_armv8m_main_ns)
    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            arm_cm35p )

    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            arm_cm35p_fpv5_sp_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv8m_main_ns
                            arm_cm35p_fpv5_sp_d16_hard )
endif()

if(TARGET freertos_port_armv8m_main_ntz)
    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ns
                            arm_cm35p )

    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            arm_cm35p_fpv5_sp_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv8m_main_ntz
                            arm_cm35p_fpv5_sp_d16_hard )
endif()

###############################################################################
# ARMv8.1-M Main
###############################################################################
define_arch_variant( armv81m_main
                     "-march=armv8.1-m.main+nofp+nomve"
                     "-mfloat-abi=soft"
                     "" )

# Single Precision Floating Point
define_arch_variant( armv81m_main_fpv5_sp_d16_softfp
                     "-march=armv8.1-m.main+nomve+fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv81m_main_fpv5_sp_d16_hard
                     "-march=armv8.1-m.main+nomve+fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

# Double Precision Floating Point
define_arch_variant( armv81m_main_fpv5_d16_softfp
                     "-march=armv8.1-m.main+nomve+fp.dp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv81m_main_fpv5_d16_hard
                     "-march=armv8.1-m.main+nomve+fp.dp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

# TODO Half-precision support

if(TARGET freertos_port_armv81m_main_ns)
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main )

    # Single Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_sp_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_sp_d16_hard )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_d16_hard )
endif()

if(TARGET freertos_port_armv81m_main_ntz)
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main )

    # Single Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_sp_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_sp_d16_hard )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_d16_hard )
endif()

###############################################################################
# ARMv8.1-M Main MVE
###############################################################################
define_arch_variant( armv81m_main_mve
                     "-march=armv8.1-m.main+mve+nofp"
                     "-mfloat-abi=soft"
                     "" )

define_arch_variant( armv81m_main_fpv5_sp_d16_mve_softfp
                     "-march=armv8.1-m.main+mve+fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv81m_main_fpv5_sp_d16_mve_hard
                     "-march=armv8.1-m.main+mve+fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv81m_main_fpv5_d16_mve_softfp
                     "-march=armv8.1-m.main+mve+fp.dp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv81m_main_fpv5_d16_mve_hard
                     "-march=armv8.1-m.main+mve+fp.dp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

# TODO Half-precision support

if(TARGET freertos_port_armv81m_main_ns)
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_mve )
    # Single Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_sp_d16_mve_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_sp_d16_mve_hard )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_d16_mve_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_d16_mve_hard )
endif()

if(TARGET freertos_port_armv81m_main_ntz)
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_mve )

    # Single Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_sp_d16_mve_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_sp_d16_mve_hard )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_d16_mve_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_d16_mve_hard )
endif()

###############################################################################
# ARMv8.1-M Main MVE.fp
###############################################################################

# Single Precision FP
define_arch_variant( armv81m_main_fpv5_sp_d16_mve_fp_softfp
                     "-march=armv8.1-m.main+mve.fp+fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_arch_variant( armv81m_main_fpv5_sp_d16_mve_fp_hard
                     "-march=armv8.1-m.main+mve.fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )
# Double Precision FP
define_arch_variant( armv81m_main_fpv5_d16_mve_fp_softfp
                     "-march=armv8.1-m.main+mve.fp+fp.dp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_arch_variant( armv81m_main_fpv5_d16_mve_fp_hard
                     "-march=armv8.1-m.main+mve.fp+fp.dp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

# TODO Half-precision support

if(TARGET freertos_port_armv81m_main_ns)
    # Single Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_sp_d16_mve_fp_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_sp_d16_mve_fp_hard )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_d16_mve_fp_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            armv81m_main_fpv5_d16_mve_fp_hard )
endif()

if(TARGET freertos_port_armv81m_main_ntz)
    # Single Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_sp_d16_mve_fp_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_sp_d16_mve_fp_hard )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_d16_mve_fp_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            armv81m_main_fpv5_d16_mve_fp_hard )
endif()

###############################################################################
# ARM Cortex-M55
###############################################################################
define_cpu_fp_variant( arm_cm55
                       "-mcpu=cortex-m55+nomve+nofp"
                       "-mfloat-abi=soft"
                       "" )

# Single Precision FP
define_cpu_fp_variant( arm_cm55_fpv5_sp_d16_softfp
                       "-mcpu=cortex-m55+nomve+fp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-sp-d16" )

define_cpu_fp_variant( arm_cm55_fpv5_sp_d16_hard
                       "-mcpu=cortex-m55+nomve+fp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-sp-d16" )

# Double Precision FP
define_cpu_fp_variant( arm_cm55_fpv5_d16_softfp
                       "-mcpu=cortex-m55+nomve+fp.dp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-d16" )

define_cpu_fp_variant( arm_cm55_fpv5_d16_hard
                       "-mcpu=cortex-m55+nomve+fp.dp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-d16" )

if(TARGET freertos_port_armv81m_main_ns)
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            arm_cm55 )

    # Single Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            arm_cm55_fpv5_sp_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            arm_cm55_fpv5_sp_d16_hard )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            arm_cm55_fpv5_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_armv81m_main_ns
                            arm_cm55_fpv5_d16_hard )
endif()

if(TARGET freertos_port_armv81m_main_ntz)
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            arm_cm55 )

    # Single Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            arm_cm55_fpv5_sp_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            arm_cm55_fpv5_sp_d16_hard )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            arm_cm55_fpv5_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_armv81m_main_ntz
                            arm_cm55_fpv5_d16_hard )
endif()
###############################################################################
# ARM Cortex-M55 MVE
###############################################################################
define_cpu_fp_variant( arm_cm55_mve
                       "-mcpu=cortex-m55+mve+nofp"
                       "-mfloat-abi=soft"
                       "" )

define_cpu_fp_variant( arm_cm55_fpv5_sp_d16_mve_softfp
                       "-mcpu=cortex-m55+mve+fp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-sp-d16" )

define_cpu_fp_variant( arm_cm55_fpv5_sp_d16_mve_hard
                       "-mcpu=cortex-m55+mve+fp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-sp-d16" )

# Double Precision FP
define_cpu_fp_variant( arm_cm55_fpv5_d16_mve_softfp
                       "-mcpu=cortex-m55+mve+fp.dp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-d16" )

define_cpu_fp_variant( arm_cm55_fpv5_d16_mve_hard
                       "-mcpu=cortex-m55+mve+fp.dp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-d16" )

###############################################################################
# ARM Cortex-M55 MVE.fp
###############################################################################

###############################################################################
# ARM Cortex-M85
###############################################################################

###############################################################################
# ARM Cortex-M85 MVE
###############################################################################

###############################################################################
# Cortex-M85 MVE.fp
###############################################################################
