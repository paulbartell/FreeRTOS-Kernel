###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

include(config.cmake)

###############################################################################
# Helper function to add a new static kernel build configuration
###############################################################################
function(add_static_kernel_target target_basename port_target_name arch_target_variant )
    set( static_target_name ${target_basename}_${arch_target_variant} )

    add_library( ${static_target_name} STATIC )

    target_link_libraries( ${static_target_name}
                            PRIVATE
                                ${port_target_name}
                                FreeRTOS::Kernel::Core
                            PUBLIC
                                ${arch_target_variant} )

    target_add_freertos_config( ${static_target_name} )

    if(NOT TARGET ${arch_target_variant})
        message( FATAL_ERROR "Target Variant ${arch_target_variant} is not defined." )
    endif()

    if(NOT TARGET ${port_target_name})
        message( FATAL_ERROR "Port Target ${port_target_name} is not defined." )
    endif()
endfunction()

add_subdirectory(armv6-m)
add_subdirectory(armv7-m)
add_subdirectory(armv7e-m)

add_subdirectory(avr)