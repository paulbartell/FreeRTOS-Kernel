###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7-M Port
###############################################################################
add_library( freertos_port_armv7m INTERFACE )

target_sources( freertos_port_armv7m INTERFACE port.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( freertos_port_armv7m PUBLIC portmacro.h )
    target_include_directories( freertos_port_armv7m INTERFACE . )
else()
    target_sources( freertos_port_armv7m
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::Port::ARMv7-M ALIAS freertos_port_armv7m )
add_library( FreeRTOS::Kernel::Port::Cortex-M3 ALIAS freertos_port_armv7m )
