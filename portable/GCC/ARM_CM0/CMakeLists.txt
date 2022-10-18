###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv6-M
###############################################################################
add_library( port_armv6m INTERFACE )

target_sources( port_armv6m INTERFACE port.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( port_armv6m PUBLIC portmacro.h )
    target_include_directories( port_armv6m PUBLIC . )
else()
    target_sources( port_armv6m
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::ARMv6-M ALIAS port_armv6m )

###############################################################################
# ARM Cortex-M0 static library target
###############################################################################
add_library( port_cortex_m0 STATIC )

target_link_libraries( port_cortex_m0 PRIVATE port_armv6m )
target_link_libraries( port_cortex_m0 PRIVATE FreeRTOS::Kernel::Core )

target_include_directories( port_cortex_m0
                            PUBLIC
                                .
                                ${CMAKE_CURRENT_BINARY_DIR} )

target_compile_options( port_cortex_m0
                        PUBLIC
                            "-march=armv6-m"
                            "-mcpu=cortex-m0" )

configure_file( ../../../FreeRTOSConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/FreeRTOSConfig.h )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources(  port_cortex_m0 PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/FreeRTOSConfig.h )
    target_include_directories( port_cortex_m0 PUBLIC ${CMAKE_CURRENT_BINARY_DIR} )
else()
    target_sources( port_cortex_m0
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}
                FILES ${CMAKE_CURRENT_BINARY_DIR}/FreeRTOSConfig.h )
endif()

add_library( FreeRTOS::Kernel::Cortex-M0 ALIAS port_cortex_m0 )
