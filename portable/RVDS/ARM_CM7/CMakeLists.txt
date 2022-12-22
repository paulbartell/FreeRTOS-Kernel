###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM_CM7
###############################################################################

message( FATAL_ERROR "Give ARM_CM7 an alias and remove this message" )

freertos_define_port(
    NAME freertos_port_arm_cm7
    ALIAS # TODO:
    HEADERS
    SOURCES
)
