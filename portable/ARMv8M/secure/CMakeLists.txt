###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv8-M / ARMv8.1-M Non-Secure / Non-TrustZone
###############################################################################
add_library( port_armv8m_s
             INTERFACE
             init/secure_init.h
             init/secure_init.c
             context/secure_context.c
             context/secure_context.h
             heap/secure_heap.h
             heap/secure_heap.c
             macros/secure_port_macros.h )

target_include_directories( port_armv8m_s
                            INTERFACE
                            init
                            context
                            heap
                            macros )

if(CMAKE_C_COMPILER_ID STREQUAL IAR)
    set(ARMV8M_COMPILER_FAMILY IAR)
    set(ARMV8M_S_CONTEXT_PORT secure_context_port_asm.s )
else()
    set(ARMV8M_COMPILER_FAMILY GCC)
    set(ARMV8M_S_CONTEXT_PORT secure_context_port.c)
endif()

###############################################################################
# Cortex-M23 S
###############################################################################
add_library( port_armv8m_cm23_s
             INTERFACE
             context/portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM23/${ARMV8M_S_CONTEXT_PORT} )

target_link_libraries( port_armv8m_cm23_s INTERFACE port_armv8m_s )

###############################################################################
# Cortex-M33 S
###############################################################################
add_library( port_armv8m_cm33_s
             INTERFACE
             context/portable/${ARMV8M_COMPILER_FAMILY}/ARM_CM33/${ARMV8M_S_CONTEXT_PORT} )

target_link_libraries( port_armv8m_cm33_s INTERFACE port_armv8m_s )

###############################################################################
# Cortex-M55 S
###############################################################################
add_library( port_armv8m_cm55_s ALIAS port_armv8m_cm33_s )

###############################################################################
# Cortex-M85 S
###############################################################################
add_library( port_armv8m_cm85_s ALIAS port_armv8m_cm33_s )
