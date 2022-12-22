###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM_CM4F
###############################################################################

message( FATAL_ERROR "Give ARM_CM4F an alias and remove this message" )

freertos_define_port(
    NAME freertos_port_arm_cm4f
    ALIAS # TODO:
    HEADERS
        portmacro.h
    SOURCES
        port.c
)
