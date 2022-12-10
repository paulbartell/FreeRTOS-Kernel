###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Generic ARMv7E-M
###############################################################################
if(TARGET freertos_port_armv7em)
    # # Generic ARMv7E-M
    # add_static_kernel_target( freertos_kernel_armv7em freertos_port_armv7em )

    # target_compile_options( freertos_kernel_armv7em
    #                         PUBLIC
    #                             "-march=armv7e-m"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_armv7em )

    # # Generic ARMv7E-M with Soft FP
    # add_static_kernel_target( freertos_kernel_armv7em_softfp freertos_port_armv7em )

    # target_compile_options( freertos_kernel_armv7em_softfp
    #                         PUBLIC
    #                             "-march=armv7e-m"
    #                             "-mfloat-abi=softfp"
    #                             "-mfpu=auto" )

    # target_add_freertos_config( freertos_kernel_armv7em_softfp )

    # Generic ARMv7E-M with FPv4 Single Precision Hard FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv4_sp_d16 freertos_port_armv7em )

    target_compile_options( freertos_kernel_armv7em_fpv4_sp_d16
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv4-sp-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv4_sp_d16 )

    # Generic ARMv7E-M with FPv5 Double Precision Hard FP (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv5_d16 freertos_port_armv7em )

    target_compile_options( freertos_kernel_armv7em_fpv5_d16
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv5_d16 )

    # Generic ARMv7E-M with FPv5 Single Precision Hard FP (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv5_sp_d16 freertos_port_armv7em )

    target_compile_options( freertos_kernel_armv7em_fpv5_sp_d16
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv5_sp_d16 )
endif()

###############################################################################
# ARM Cortex-M4
###############################################################################
if(TARGET freertos_port_armv7em)
    # # Cortex-M4
    # add_static_kernel_target( freertos_kernel_cortex_m4 freertos_port_armv7em )

    # target_compile_options( freertos_kernel_cortex_m4
    #                         PUBLIC
    #                             "-mcpu=cortex-m4"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m4 )

    # Cortex-M4 + softfp
    add_static_kernel_target( freertos_kernel_cortex_m4_softfp freertos_port_armv7em )

    target_compile_options( freertos_kernel_cortex_m4_softfp
                            PUBLIC
                                "-mcpu=cortex-m4"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m4_softfp )

    # Cortex-M4 with FPv4 Single Precision Hard FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_cortex_m4_fpv4_sp_d16 freertos_port_armv7em )

    target_compile_options( freertos_kernel_cortex_m4_fpv4_sp_d16
                            PUBLIC
                                "-mcpu=cortex-m4"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv4-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m4_fpv4_sp_d16 )
endif()

###############################################################################
# ARM Cortex-M7
###############################################################################
if(TARGET freertos_port_armv7em)
    # # Cortex-M7
    # add_static_kernel_target( freertos_kernel_cortex_m7 freertos_port_armv7em )

    # target_compile_options( freertos_kernel_cortex_m7
    #                         PUBLIC
    #                             "-mcpu=cortex-m7"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m7 )

    # Cortex-M7 + softfp
    add_static_kernel_target( freertos_kernel_cortex_m7_softfp freertos_port_armv7em )

    target_compile_options( freertos_kernel_cortex_m7_softfp
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m7_softfp )

    # Cortex-M7 with FPv5-DP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_fpv5_d16 freertos_port_armv7em )

    target_compile_options( freertos_kernel_cortex_m7_fpv5_d16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_fpv5_d16 )

    # Cortex-M7 with FPv5-SP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_fpv5_sp_d16 freertos_port_armv7em )

    target_compile_options( freertos_kernel_cortex_m7_fpv5_sp_d16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 with r0p1 erratam
###############################################################################
if(TARGET freertos_port_armv7em_cortex_m7_r0p1)
    # # Cortex-M7 r0p1
    # add_static_kernel_target( freertos_kernel_cortex_m7_r0p1 freertos_port_armv7em_cortex_m7_r0p1 )

    # target_compile_options( freertos_kernel_cortex_m7_r0p1
    #                         PUBLIC
    #                             "-mcpu=cortex-m7"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m7_r0p1 )

    # Cortex-M7 r0p1 + softfp
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_softfp freertos_port_armv7em_cortex_m7_r0p1 )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_softfp
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_softfp )

    # Cortex-M7 r0p1 FPv5-DP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_fpv5_d16 freertos_port_armv7em_cortex_m7_r0p1 )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_fpv5_d16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_fpv5_d16 )

    # Cortex-M7 r0p1 with FPv5-SP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16 freertos_port_armv7em_cortex_m7_r0p1 )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16 )
endif()

###############################################################################
# ARMv7E-M Generic + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configTOTAL_MPU_REGIONS 8)

    # # Generic ARMv7E-M
    # # Note CM4F port only suports with fpu?
    # add_static_kernel_target( freertos_kernel_armv7em_mpu8 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_armv7em_mpu8
    #                         PUBLIC
    #                             "-march=armv7e-m"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_armv7em_mpu8 )

    # # Generic ARMv7E-M with Soft FP
    # add_static_kernel_target( freertos_kernel_armv7em_softfp_mpu8 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_armv7em_softfp_mpu8
    #                         PUBLIC
    #                             "-march=armv7e-m"
    #                             "-mfloat-abi=softfp"
    #                             "-mfpu=auto" )

    # target_add_freertos_config( freertos_kernel_armv7em_softfp_mpu8 )

    # Generic ARMv7E-M with FPv4 Single Precision Hard FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv4_sp_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_armv7em_fpv4_sp_d16_mpu8
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv4-sp-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv4_sp_d16_mpu8 )

    # Generic ARMv7E-M with FPv5 Double Precision Hard FP (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv5_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_armv7em_fpv5_d16_mpu8
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv5_d16_mpu8 )

    # Generic ARMv7E-M with FPv5 Single Precision Hard FP (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv5_sp_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_armv7em_fpv5_sp_d16_mpu8
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv5_sp_d16_mpu8 )

endif()

###############################################################################
# ARMv7E-M Generic + 16 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configTOTAL_MPU_REGIONS 16)

    # # Generic ARMv7E-M
    # # Note CM4F port only suports with fpu?
    # add_static_kernel_target( freertos_kernel_armv7em_mpu16 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_armv7em_mpu16
    #                         PUBLIC
    #                             "-march=armv7e-m"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_armv7em_mpu16 )

    # # Generic ARMv7E-M with Soft FP
    # add_static_kernel_target( freertos_kernel_armv7em_softfp_mpu16 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_armv7em_softfp_mpu16
    #                         PUBLIC
    #                             "-march=armv7e-m"
    #                             "-mfloat-abi=softfp"
    #                             "-mfpu=auto" )

    # target_add_freertos_config( freertos_kernel_armv7em_softfp_mpu16 )

    # Generic ARMv7E-M with FPv4 Single Precision Hard FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv4_sp_d16_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_armv7em_fpv4_sp_d16_mpu16
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv4-sp-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv4_sp_d16_mpu16 )

    # Generic ARMv7E-M with FPv5 Double Precision Hard FP (FPv5-DP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv5_d16_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_armv7em_fpv5_d16_mpu16
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv5_d16_mpu16 )

    # Generic ARMv7E-M with FPv5 Single Precision Hard FP (FPv5-SP-D16)
    add_static_kernel_target( freertos_kernel_armv7em_fpv5_sp_d16_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_armv7em_fpv5_sp_d16_mpu16
                            PUBLIC
                                "-march=armv7e-m"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_armv7em_fpv5_sp_d16_mpu16 )

endif()

###############################################################################
# ARMv7E-M Cortex-M4 + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configTOTAL_MPU_REGIONS 8)

    # # Cortex-M4
    # add_static_kernel_target( freertos_kernel_cortex_m4_mpu8 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_cortex_m4_mpu8
    #                         PUBLIC
    #                             "-mcpu=cortex-m4"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m4_mpu8 )

    # Cortex-M4 + softfp
    add_static_kernel_target( freertos_kernel_cortex_m4_softfp_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m4_softfp_mpu8
                            PUBLIC
                                "-mcpu=cortex-m4"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m4_softfp_mpu8 )

    # Cortex-M4 with FPv4 Single Precision Hard FP (FPv4-SP-D16)
    add_static_kernel_target( freertos_kernel_cortex_m4_fpv4_sp_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m4_fpv4_sp_d16_mpu8
                            PUBLIC
                                "-mcpu=cortex-m4"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv4-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m4_fpv4_sp_d16_mpu8 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configTOTAL_MPU_REGIONS 8)

    # # Cortex-M7
    # add_static_kernel_target( freertos_kernel_cortex_m7_mpu8 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_cortex_m7_mpu8
    #                         PUBLIC
    #                             "-mcpu=cortex-m7"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m7_mpu8 )

    # Cortex-M7 + softfp
    add_static_kernel_target( freertos_kernel_cortex_m7_softfp_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_softfp_mpu8
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m7_softfp_mpu8 )

    # Cortex-M7 with FPv5-DP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_fpv5_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_fpv5_d16_mpu8
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_fpv5_d16_mpu8 )

    # Cortex-M7 with FPv5-SP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_fpv5_sp_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_fpv5_sp_d16_mpu8
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_fpv5_sp_d16_mpu8 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 + 16 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configTOTAL_MPU_REGIONS 16)

    # # Cortex-M7
    # add_static_kernel_target( freertos_kernel_cortex_m7_mpu16 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_cortex_m7_mpu16
    #                         PUBLIC
    #                             "-mcpu=cortex-m7"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m7_mpu16 )

    # Cortex-M7 + softfp
    add_static_kernel_target( freertos_kernel_cortex_m7_softfp_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_softfp_mpu16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m7_softfp_mpu16 )

    # Cortex-M7 with FPv5-DP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_fpv5_d16_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_fpv5_d16_mpu16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_fpv5_d16_mpu16 )

    # Cortex-M7 with FPv5-SP-D16 fpu
    add_static_kernel_target( freertos_kernel_cortex_m7_fpv5_sp_d16_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_fpv5_sp_d16_mpu16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_fpv5_sp_d16_mpu16 )
endif()

###############################################################################
# ARMv7E-M Cortex-M7 r0p1 + 8 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configTOTAL_MPU_REGIONS 8)
    set(configENABLE_ERRATA_837070_WORKAROUND ON)

    # # Cortex-M7 r0p1 MPU
    # add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_mpu8 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_cortex_m7_r0p1_mpu8
    #                         PUBLIC
    #                             "-mcpu=cortex-m7"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_mpu8 )

    # Cortex-M7 r0p1 + softfp MPU
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_softfp_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_softfp_mpu8
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_softfp_mpu8 )

    # Cortex-M7 r0p1 FPv5-DP-D16 fpu MPU
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_fpv5_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_fpv5_d16_mpu8
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_fpv5_d16_mpu8 )

    # Cortex-M7 r0p1 with FPv5-SP-D16 fpu MPU
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16_mpu8 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16_mpu8
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16_mpu8 )

endif()

###############################################################################
# ARMv7E-M Cortex-M7 r0p1 + 16 Region MPU
###############################################################################
if(TARGET freertos_port_armv7em_mpu)
    set(configTOTAL_MPU_REGIONS 16)
    set(configENABLE_ERRATA_837070_WORKAROUND ON)

    # # Cortex-M7 r0p1 MPU
    # add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_mpu16 freertos_port_armv7em_mpu )

    # target_compile_options( freertos_kernel_cortex_m7_r0p1_mpu16
    #                         PUBLIC
    #                             "-mcpu=cortex-m7"
    #                             "-mfloat-abi=soft" )

    # target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_mpu16 )

    # Cortex-M7 r0p1 + softfp MPU
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_softfp_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_softfp_mpu16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=softfp"
                                "-mfpu=auto" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_softfp_mpu16 )

    # Cortex-M7 r0p1 FPv5-DP-D16 fpu MPU
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_fpv5_d16_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_fpv5_d16_mpu16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_fpv5_d16_mpu16 )

    # Cortex-M7 r0p1 with FPv5-SP-D16 fpu MPU
    add_static_kernel_target( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16_mpu16 freertos_port_armv7em_mpu )

    target_compile_options( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16_mpu16
                            PUBLIC
                                "-mcpu=cortex-m7"
                                "-mfloat-abi=hard"
                                "-mfpu=fpv5-sp-d16" )

    target_add_freertos_config( freertos_kernel_cortex_m7_r0p1_fpv5_sp_d16_mpu16 )

endif()
