###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# YOUR PORT
###############################################################################
message( FATAL_ERROR "Replace your_port with a port name and remove this message" )

add_library( freertos_port_your_port INTERFACE )

target_sources( freertos_port_your_port
    INTERFACE 
        portASM.S # Only needed if your port requires some assembly
        port.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( freertos_port_your_port PUBLIC portmacro.h )
    target_include_directories( freertos_port_your_port INTERFACE . )
else()
    target_sources( freertos_port_your_port
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::Port::YOUR_PORT ALIAS freertos_port_your_port )
