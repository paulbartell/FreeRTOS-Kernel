###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARMv7E-M MPU
###############################################################################
add_library( freertos_port_armv7em_mpu INTERFACE )

target_sources( freertos_port_armv7em_mpu
                INTERFACE
                    port.c
                    ../../Common/mpu_wrappers.c )

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    target_sources( freertos_port_armv7em_mpu PUBLIC portmacro.h )
    target_include_directories( freertos_port_armv7em_mpu INTERFACE . )
else()
    target_sources( freertos_port_armv7em_mpu
        PUBLIC
            FILE_SET HEADERS
                BASE_DIRS .
                FILES portmacro.h )
endif()

add_library( FreeRTOS::Kernel::Port::ARMv7E-M+MPU ALIAS freertos_port_armv7em_mpu )
add_library( FreeRTOS::Kernel::Port::Cortex-M4+MPU ALIAS freertos_port_armv7em_mpu )
add_library( FreeRTOS::Kernel::Port::Cortex-M7+MPU ALIAS freertos_port_armv7em_mpu )
