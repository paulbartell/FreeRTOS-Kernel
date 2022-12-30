###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

include(config.cmake)

if(NOT BUILD_ALL_TARGETS)
    set(EXCLUDE_FLAG EXCLUDE_FROM_ALL)
endif()

###############################################################################
# Helper function to check compiler flags
###############################################################################
include(CheckCCompilerFlag)

macro ( define_variant_if_compiles VARIANT_NAME )
    set( multiValueArgs FLAGS )
    cmake_parse_arguments(VARIANT "" "" "${multiValueArgs}"  ${ARGN})
    check_c_compiler_flag("${VARIANT_FLAGS}" compiler_supports_${VARIANT_NAME})
    if( compiler_supports_${VARIANT_NAME} )
        add_library( ${VARIANT_NAME} INTERFACE )
        target_compile_options( ${VARIANT_NAME} INTERFACE ${VARIANT_FLAGS} )
    endif()
endmacro()

###############################################################################
# Helper function to add a new static kernel build configuration
###############################################################################
function(add_static_kernel_target target_basename port_target_name arch_target_variant )
    # TODO: we want to do this check elsewhere to prevent cases where a target is improperly
    # defined by a developer
    if(NOT TARGET ${arch_target_variant})
        # message( AUTHOR_WARNING "Target Variant ${arch_target_variant} is not defined." )
        return()
    endif()

    if(NOT TARGET ${port_target_name})
        message( FATAL_ERROR "Port Target ${port_target_name} is not defined." )
    endif()

    set( static_target_name ${target_basename}_${arch_target_variant} )

    add_library( ${static_target_name} STATIC ${EXCLUDE_FLAG} )

    target_link_libraries( ${static_target_name}
                            PRIVATE
                                ${port_target_name}
                                FreeRTOS::Kernel::Core
                            PUBLIC
                                ${arch_target_variant} )

    target_add_freertos_config( ${static_target_name} )

endfunction()

function(add_static_kernel2target target_suffix port_target_name arch_target_variant )
    # TODO: we want to do this check elsewhere to prevent cases where a target is improperly
    # defined by a developer
    if(NOT TARGET ${arch_target_variant})
        # message( AUTHOR_WARNING "Target Variant ${arch_target_variant} is not defined." )
        return()
    endif()

    if(NOT TARGET ${port_target_name})
        message( FATAL_ERROR "Port Target ${port_target_name} is not defined." )
    endif()

    set( static_target_name freertos_kernel_${arch_target_variant}_${target_suffix})

    add_library( ${static_target_name} STATIC ${EXCLUDE_FLAG} )

    target_link_libraries( ${static_target_name}
                            PRIVATE
                                ${port_target_name}
                                FreeRTOS::Kernel::Core
                            PUBLIC
                                ${arch_target_variant} )

    target_add_freertos_config( ${static_target_name} )

endfunction()

add_subdirectory(armv6-m)
add_subdirectory(armv7-m)
add_subdirectory(armv7e-m)
add_subdirectory(armv8-m)
add_subdirectory(armv8.1-m)
add_subdirectory(avr)
