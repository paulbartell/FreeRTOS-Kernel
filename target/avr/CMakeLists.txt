###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ATMega323
###############################################################################
if(TARGET freertos_port_atmega323)
    set(configENABLE_ERRATA_837070_WORKAROUND OFF)
    add_library( avr_atmega323 INTERFACE )
    add_static_kernel_target( freertos_kernel
                              freertos_port_atmega323
                              avr_atmega323 )
    target_compile_options( avr_atmega323
                            INTERFACE
                                "-mmcu=atmega323" )
endif()
