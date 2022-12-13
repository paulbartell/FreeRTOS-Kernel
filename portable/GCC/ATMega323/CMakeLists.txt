###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

add_library( freertos_port_atmega323 INTERFACE )

target_sources( freertos_port_atmega323 INTERFACE port.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( freertos_port_atmega323 PUBLIC portmacro.h )
    target_include_directories( freertos_port_atmega323 INTERFACE . )
else()
    target_sources( freertos_port_atmega323
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::Port::ATMega323 ALIAS freertos_port_atmega323 )
