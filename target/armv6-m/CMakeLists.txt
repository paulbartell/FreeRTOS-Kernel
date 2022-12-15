###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

    macro(define_armv6m_cpu arch_variant_name arch_opt cpu_opt )
        can_compile_with_flags( "${arch_opt};${cpu_opt}" can_compile )
        if(can_compile EQUAL 1)
            add_library( ${arch_variant_name} INTERFACE )

            target_compile_options( ${arch_variant_name}
                                    INTERFACE
                                        ${arch_opt}
                                        ${cpu_opt}
                                        "-mthumb" )
        endif()
    endmacro()

    ###############################################################################
    # Define ARMv6-M architecture variants
    ###############################################################################
    add_library( armv6m INTERFACE )

    target_compile_options( armv6m
                            INTERFACE
                                "-march=armv6s-m"
                                "-mthumb" )

    define_armv6m_cpu( arm_cm0
                    "-march=armv6s-m"
                    "-mcpu=cortex-m0" )

    define_armv6m_cpu( arm_cm0_small_multiply
                    "-march=armv6s-m"
                    "-mcpu=cortex-m0.small-multiply" )

    define_armv6m_cpu( arm_cm0plus
                    "-march=armv6s-m"
                    "-mcpu=cortex-m0plus" )

    define_armv6m_cpu( arm_cm0plus_small_multiply
                    "-march=armv6s-m"
                    "-mcpu=cortex-m0plus.small-multiply" )

    define_armv6m_cpu( arm_cm1
                    "-march=armv6s-m"
                    "-mcpu=cortex-m1" )

    define_armv6m_cpu( arm_cm1_small_multiply
                    "-march=armv6s-m"
                    "-mcpu=cortex-m1.small-multiply" )

    ###############################################################################
    # ARMv6M
    ###############################################################################
    if(TARGET freertos_port_armv6m)
        # Generic ARMv6-M
        add_static_kernel_target( fr_kernel
                                freertos_port_armv6m
                                armv6m )

        # Cortex-M0
        add_static_kernel_target( fr_kernel
                                freertos_port_armv6m
                                arm_cm0 )

        # Cortex-M0 Small Multiply
        add_static_kernel_target( fr_kernel
                                freertos_port_armv6m
                                arm_cm0_small_multiply )

        # Cortex-M0+
        add_static_kernel_target( fr_kernel
                                freertos_port_armv6m
                                arm_cm0plus )

        # Cortex-M0+ Small Multiply
        add_static_kernel_target( fr_kernel
                                freertos_port_armv6m
                                arm_cm0plus_small_multiply )

        # Cortex-M1
        add_static_kernel_target( fr_kernel
                                freertos_port_armv6m
                                arm_cm1 )

        # Cortex-M1 Small Multiply
        add_static_kernel_target( fr_kernel
                                freertos_port_armv6m
                                arm_cm1_small_multiply )
    endif()
