###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

include(config.cmake)

###############################################################################
# Helper function to add a new static kernel build configuration
###############################################################################
function(add_static_kernel_target static_target_name port_target_name )
    add_library( ${static_target_name} STATIC )

    target_link_libraries( ${static_target_name}
                            PRIVATE
                                ${port_target_name}
                                FreeRTOS::Kernel::Core )
endfunction()


add_subdirectory(armv6-m)
add_subdirectory(armv7-m)
add_subdirectory(armv7e-m)
