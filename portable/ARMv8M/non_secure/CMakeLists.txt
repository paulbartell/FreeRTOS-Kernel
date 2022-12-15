###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv8-M / ARMv8.1-M Non-Secure / Non-TrustZone
###############################################################################
add_library( freertos_port_armv8m_ns
             INTERFACE
             port.c
             portasm.h
             portmacrocommon.h
             ../../Common/mpu_wrappers.c )

target_include_directories( freertos_port_armv8m_ns
                            INTERFACE
                            . )

if(CMAKE_C_COMPILER_ID STREQUAL IAR)
    set(ARMV8M_COMPILER_FAMILY IAR)
    set(ARMV8M_PORTASM portasm.s)
else()
    set(ARMV8M_COMPILER_FAMILY GCC)
    set(ARMV8M_PORTASM portasm.c)
endif()

###############################################################################
# Cortex-M23 NS
###############################################################################
add_library( freertos_port_armv8m_base_ns
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM23/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM23/portmacro.h )

target_include_directories( freertos_port_armv8m_base_ns
                            INTERFACE
                            portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM23 )

target_link_libraries( freertos_port_armv8m_base_ns INTERFACE freertos_port_armv8m_ns )
add_library( FreeRTOS::Kernel::Port::Cortex-M23::NS ALIAS freertos_port_armv8m_base_ns )

###############################################################################
# Cortex-M23 NTZ
###############################################################################
add_library( freertos_port_armv8m_base_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM23_NTZ/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM23_NTZ/portmacro.h )

target_include_directories( freertos_port_armv8m_base_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM23_NTZ )

target_link_libraries( freertos_port_armv8m_base_ntz INTERFACE freertos_port_armv8m_ns )
add_library( FreeRTOS::Kernel::Port::Cortex-M23::NTZ ALIAS freertos_port_armv8m_base_ntz )

###############################################################################
# Cortex-M33 NS
###############################################################################
add_library( freertos_port_armv8m_main_ns
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33/portmacro.h )

target_include_directories( freertos_port_armv8m_main_ns
                            INTERFACE
                            portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33 )

target_link_libraries( freertos_port_armv8m_main_ns INTERFACE freertos_port_armv8m_ns )
add_library( FreeRTOS::Kernel::Port::Cortex-M33::NS ALIAS freertos_port_armv8m_main_ns )

###############################################################################
# Cortex-M33 NTZ
###############################################################################
add_library( freertos_port_armv8m_main_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33_NTZ/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33_NTZ/portmacro.h )

target_include_directories( freertos_port_armv8m_main_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33_NTZ )

target_link_libraries( freertos_port_armv8m_main_ntz INTERFACE freertos_port_armv8m_ns )
add_library( FreeRTOS::Kernel::Port::Cortex-M33::NTZ ALIAS freertos_port_armv8m_main_ntz )

###############################################################################
# ARMv8.1M.main / Cortex-M55 NS
###############################################################################
add_library( freertos_port_armv81m_main_ns
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM55/portmacro.h )

target_include_directories( freertos_port_armv81m_main_ns
                            INTERFACE
                            portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM55 )

target_link_libraries( freertos_port_armv81m_main_ns INTERFACE freertos_port_armv8m_ns )

add_library( freertos_port_arm_cm55_ns ALIAS freertos_port_armv81m_main_ns )
add_library( FreeRTOS::Kernel::Port::Cortex-M55::NS ALIAS freertos_port_armv81m_main_ns )

###############################################################################
# Cortex-M55 NTZ
###############################################################################
add_library( freertos_port_armv81m_main_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33_NTZ/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM55/portmacro.h )

target_include_directories( freertos_port_armv81m_main_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM55 )

target_link_libraries( freertos_port_armv81m_main_ntz INTERFACE freertos_port_armv8m_ns )

add_library( freertos_port_arm_cm55_ntz ALIAS freertos_port_armv81m_main_ntz )
add_library( FreeRTOS::Kernel::Port::Cortex-M55::NTZ ALIAS freertos_port_armv81m_main_ntz )

###############################################################################
# Cortex-M85 NS
###############################################################################
add_library( freertos_port_arm_cm85_ns
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM85/portmacro.h )

target_include_directories( freertos_port_arm_cm85_ns
                            INTERFACE
                            portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM85 )

target_link_libraries( freertos_port_arm_cm85_ns INTERFACE freertos_port_armv8m_ns )
add_library( FreeRTOS::Kernel::Port::Cortex-M85::NS ALIAS freertos_port_arm_cm85_ns )

###############################################################################
# Cortex-M85 NTZ
###############################################################################
add_library( freertos_port_arm_cm85_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33_NTZ/${ARMV8M_PORTASM}
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM85/portmacro.h )

target_include_directories( freertos_port_armv8m_cm85_ntz
             INTERFACE
             portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM85 )

target_link_libraries( freertos_port_arm_cm85_ntz INTERFACE freertos_port_armv8m_ns )
add_library( FreeRTOS::Kernel::Port::Cortex-M85::NTZ ALIAS freertos_port_arm_cm85_ntz )
