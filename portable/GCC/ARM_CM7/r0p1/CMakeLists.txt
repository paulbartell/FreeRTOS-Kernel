###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7E-M Port for Cortex-M7 r0p1
###############################################################################
add_library( freertos_port_armv7em_cortex_m7_r0p1 INTERFACE )

target_sources( freertos_port_armv7em_cortex_m7_r0p1 INTERFACE port.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( freertos_port_armv7em_cortex_m7_r0p1 PUBLIC portmacro.h )
    target_include_directories( freertos_port_armv7em_cortex_m7_r0p1 INTERFACE . )
else()
    target_sources( freertos_port_armv7em_cortex_m7_r0p1
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::Port::Cortex-M7-r0p1 ALIAS freertos_port_armv7em_cortex_m7_r0p1 )
