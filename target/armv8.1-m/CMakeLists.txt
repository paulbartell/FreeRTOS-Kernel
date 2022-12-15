###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

macro(define_armv8m_variant arch_variant arch_opt float_abi_opt fpu_opt )
    add_library( ${arch_variant} INTERFACE )

    target_compile_options( ${arch_variant}
                            INTERFACE
                                ${arch_opt}
                                "-mthumb"
                                ${float_abi_opt}
                                ${fpu_opt} )
endmacro()

macro(define_cpu_fp_variant arch_variant cpu_opt arch_opt float_abi_opt fpu_opt )
    add_library( ${arch_variant} INTERFACE )

    target_compile_options( ${arch_variant}
                            INTERFACE
                                ${arch_opt}
                                ${cpu_opt}
                                "-mthumb"
                                ${float_abi_opt}
                                ${fpu_opt} )
endmacro()

function(add_fr_config_variants target_suffix port arch_variant)
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
    if(${arch_variant} MATCHES "armv8m_main|armv81m_main" OR ${arch_variant} MATCHES "cm33|cm55|cm85")
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
# ARMv8.1-M Main
###############################################################################
define_armv8m_variant( armv81m_main
                     "-march=armv8.1-m.main+dsp"
                     "-mfloat-abi=soft"
                     "" )

# Single Precision Floating Point
define_armv8m_variant( armv81m_main_fpv5_sp_d16_softfp
                     "-march=armv8.1-m.main+dsp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_armv8m_variant( armv81m_main_fpv5_sp_d16_hard
                     "-march=armv8.1-m.main+dsp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

# Double Precision Floating Point
define_armv8m_variant( armv81m_main_fpv5_d16_softfp
                     "-march=armv8.1-m.main+dsp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_armv8m_variant( armv81m_main_fpv5_d16_hard
                     "-march=armv8.1-m.main+dsp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

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
define_armv8m_variant( armv81m_main_mve
                     "-march=armv8.1-m.main+dsp+mve"
                     "-mfloat-abi=soft"
                     "" )

define_armv8m_variant( armv81m_main_fpv5_sp_d16_mve_softfp
                     "-march=armv8.1-m.main+dsp+mve"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_armv8m_variant( armv81m_main_fpv5_sp_d16_mve_hard
                     "-march=armv8.1-m.main+dsp+mve"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )

define_armv8m_variant( armv81m_main_fpv5_d16_mve_softfp
                     "-march=armv8.1-m.main+dsp+mve"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_armv8m_variant( armv81m_main_fpv5_d16_mve_hard
                     "-march=armv8.1-m.main+dsp+mve"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

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
define_armv8m_variant( armv81m_main_fpv5_sp_d16_mve_fp_softfp
                     "-march=armv8.1-m.main+dsp+mve.fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-sp-d16" )

define_armv8m_variant( armv81m_main_fpv5_sp_d16_mve_fp_hard
                     "-march=armv8.1-m.main+dsp+mve.fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-sp-d16" )
# Double Precision FP
define_armv8m_variant( armv81m_main_fpv5_d16_mve_fp_softfp
                     "-march=armv8.1-m.main+dsp+mve.fp"
                     "-mfloat-abi=softfp"
                     "-mfpu=fpv5-d16" )

define_armv8m_variant( armv81m_main_fpv5_d16_mve_fp_hard
                     "-march=armv8.1-m.main+dsp+mve.fp"
                     "-mfloat-abi=hard"
                     "-mfpu=fpv5-d16" )

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
                       "-march=armv8.1-m.main+dsp"
                       "-mfloat-abi=soft"
                       "" )

# Double Precision FP
define_cpu_fp_variant( arm_cm55_fpv5_d16_softfp
                       "-mcpu=cortex-m55+nomve"
                       "-march=armv8.1-m.main+dsp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-d16" )

define_cpu_fp_variant( arm_cm55_fpv5_d16_hard
                       "-mcpu=cortex-m55+nomve"
                       "-march=armv8.1-m.main+dsp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-d16" )

if(TARGET freertos_port_arm_cm55_ns)
    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55 )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55_fpv5_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55_fpv5_d16_hard )
endif()

if(TARGET freertos_port_arm_cm55_ntz)
    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55 )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55_fpv5_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55_fpv5_d16_hard )
endif()

###############################################################################
# ARM Cortex-M55 MVE
###############################################################################
define_cpu_fp_variant( arm_cm55_mve
                       "-mcpu=cortex-m55+nomve.fp+nofp"
                       "-march=armv8.1-m.main+dsp+mve"
                       "-mfloat-abi=soft"
                       "" )

# Double Precision FP
define_cpu_fp_variant( arm_cm55_fpv5_d16_mve_softfp
                       "-mcpu=cortex-m55+nomve.fp"
                       "-march=armv8.1-m.main+dsp+mve"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-d16" )

define_cpu_fp_variant( arm_cm55_fpv5_d16_mve_hard
                       "-mcpu=cortex-m55+nomve.fp"
                       "-march=armv8.1-m.main+dsp+mve"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-d16" )

if(TARGET freertos_port_arm_cm55_ns)
    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55_mve )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55_fpv5_d16_mve_softfp )

    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55_fpv5_d16_mve_hard )
endif()

if(TARGET freertos_port_arm_cm55_ntz)
    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55_mve )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55_fpv5_d16_mve_softfp )

    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55_fpv5_d16_mve_hard )
endif()

###############################################################################
# ARM Cortex-M55 MVE.fp
###############################################################################

# Double Precision FP
define_cpu_fp_variant( arm_cm55_fpv5_d16_mve_fp_softfp
                       "-mcpu=cortex-m55"
                       "-march=armv8.1-m.main+mve.fp+fp.dp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-d16" )

define_cpu_fp_variant( arm_cm55_fpv5_d16_mve_fp_hard
                       "-mcpu=cortex-m55"
                       "-march=armv8.1-m.main+mve.fp+fp.dp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-d16" )

if(TARGET freertos_port_arm_cm55_ns)
    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55_fpv5_d16_mve_fp_softfp )

    add_fr_config_variants( ns
                            freertos_port_arm_cm55_ns
                            arm_cm55_fpv5_d16_mve_fp_hard )
endif()

if(TARGET freertos_port_arm_cm55_ntz)
    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55_fpv5_d16_mve_fp_softfp )

    add_fr_config_variants( ntz
                            freertos_port_arm_cm55_ntz
                            arm_cm55_fpv5_d16_mve_fp_hard )
endif()

###############################################################################
# ARM Cortex-M85
###############################################################################
define_cpu_fp_variant( arm_cm85
                       "-mcpu=cortex-m85+nopacbti+nofp+nomve"
                       "-march=armv8.1-m.main+dsp"
                       "-mfloat-abi=soft"
                       "" )

# Double Precision FP
define_cpu_fp_variant( arm_cm85_fpv5_d16_softfp
                       "-mcpu=cortex-m85+nomve+nopacbti"
                       "-march=armv8.1-m.main+fp.dp+dsp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-d16" )

define_cpu_fp_variant( arm_cm85_fpv5_d16_hard
                       "-mcpu=cortex-m85+nomve+nopacbti"
                       "-march=armv8.1-m.main+fp.dp+dsp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-d16" )

if(TARGET freertos_port_arm_cm85_ns)
    add_fr_config_variants( ns
                            freertos_port_arm_cm85_ns
                            arm_cm85 )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_arm_cm85_ns
                            arm_cm85_fpv5_d16_softfp )

    add_fr_config_variants( ns
                            freertos_port_arm_cm85_ns
                            arm_cm85_fpv5_d16_hard )
endif()

if(TARGET freertos_port_arm_cm85_ntz)
    add_fr_config_variants( ntz
                            freertos_port_arm_cm85_ntz
                            arm_cm85 )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_arm_cm85_ntz
                            arm_cm85_fpv5_d16_softfp )

    add_fr_config_variants( ntz
                            freertos_port_arm_cm85_ntz
                            arm_cm85_fpv5_d16_hard )
endif()

###############################################################################
# ARM Cortex-M85 MVE / MVE.fp
# When the Cortex-M85 is equiped with an FPU, it may not be configured with the
# integer-only mve option (ARM Document ID 101924).
###############################################################################
# No FP -> integer only mve extension
define_cpu_fp_variant( arm_cm85_mve
                       "-mcpu=cortex-m85+nopacbti+nofp"
                       "-march=armv8.1-m.main+mve+dsp"
                       "-mfloat-abi=soft"
                       "" )

# Double Precision FP -> single precision floating point mve.fp extension
define_cpu_fp_variant( arm_cm85_fpv5_d16_mve_fp_softfp
                       "-mcpu=cortex-m85+nopacbti"
                       "-march=armv8.1-m.main+fp.dp+mve.fp+dsp"
                       "-mfloat-abi=softfp"
                       "-mfpu=fpv5-d16" )

define_cpu_fp_variant( arm_cm85_fpv5_d16_mve_fp_hard
                       "-mcpu=cortex-m85+nopacbti"
                       "-march=armv8.1-m.main+fp.dp+mve.fp+dsp"
                       "-mfloat-abi=hard"
                       "-mfpu=fpv5-d16" )

if(TARGET freertos_port_arm_cm85_ns)
    add_fr_config_variants( ns
                            freertos_port_arm_cm85_ns
                            arm_cm85_mve )

    # Double Precision FP
    add_fr_config_variants( ns
                            freertos_port_arm_cm85_ns
                            arm_cm85_fpv5_d16_mve_fp_softfp )

    add_fr_config_variants( ns
                            freertos_port_arm_cm85_ns
                            arm_cm85_fpv5_d16_mve_fp_hard )
endif()

if(TARGET freertos_port_arm_cm85_ntz)
    add_fr_config_variants( ntz
                            freertos_port_arm_cm85_ntz
                            arm_cm85_mve )

    # Double Precision FP
    add_fr_config_variants( ntz
                            freertos_port_arm_cm85_ntz
                            arm_cm85_fpv5_d16_mve_fp_softfp )

    add_fr_config_variants( ntz
                            freertos_port_arm_cm85_ntz
                            arm_cm85_fpv5_d16_mve_fp_hard )
endif()
