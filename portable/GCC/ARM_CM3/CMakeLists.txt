###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7-M
###############################################################################
add_library( port_armv7m INTERFACE )

target_sources( port_armv7m INTERFACE port.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( port_armv7m PUBLIC portmacro.h )
    target_include_directories( port_armv7m PUBLIC . )
else()
    target_sources( port_armv7m
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::ARMv7-M ALIAS port_armv7m )

###############################################################################
# ARM Cortex-M3 static library target
###############################################################################
add_library( port_cortex_m3 STATIC )

target_link_libraries( port_cortex_m3 PRIVATE port_armv7m )
target_link_libraries( port_cortex_m3 PRIVATE FreeRTOS::Kernel::Core )

target_include_directories( port_cortex_m3
                            PUBLIC
                                .
                                ${CMAKE_CURRENT_BINARY_DIR} )

target_compile_options( port_cortex_m3
                        PUBLIC
                            "-march=armv7-m"
                            "-mcpu=cortex-m3" )

configure_file( ../../../FreeRTOSConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/FreeRTOSConfig.h )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources(  port_cortex_m3 PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/FreeRTOSConfig.h )
    target_include_directories( port_cortex_m3 PUBLIC ${CMAKE_CURRENT_BINARY_DIR} )
else()
    target_sources( port_cortex_m3
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}
                FILES ${CMAKE_CURRENT_BINARY_DIR}/FreeRTOSConfig.h )
endif()
