###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Posix Port
###############################################################################
add_library( freertos_port_posix INTERFACE )

target_sources( freertos_port_posix
                INTERFACE
                port.c
                utils/wait_for_event.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( freertos_port_posix
                    PUBLIC
                    portmacro.h
                    utils/wait_for_event.h )
    target_include_directories( freertos_port_posix
                                INTERFACE
                                .
                                utils )
else()
    target_sources( freertos_port_posix
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES
                    portmacro.h
                    utils/wait_for_event.h )
endif()

add_library( FreeRTOS::Kernel::Port::Posix ALIAS freertos_port_posix )
