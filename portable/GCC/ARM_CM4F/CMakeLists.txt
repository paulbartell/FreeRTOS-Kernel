###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7E-M Port
###############################################################################
add_library( freertos_port_armv7em INTERFACE )

target_sources( freertos_port_armv7em INTERFACE port.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( freertos_port_armv7em PUBLIC portmacro.h )
    target_include_directories( freertos_port_armv7em PUBLIC . )
else()
    target_sources( freertos_port_armv7em
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::Port::ARMv7E-M ALIAS freertos_port_armv7em )
add_library( FreeRTOS::Kernel::Port::Cortex-M4 ALIAS freertos_port_armv7em )
add_library( FreeRTOS::Kernel::Port::Cortex-M7 ALIAS freertos_port_armv7em )

