###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ATmega
###############################################################################

message( FATAL_ERROR "Give ATmega an alias and remove this message" )

freertos_define_port(
    NAME freertos_port_atmega
    ALIAS # TODO:
    HEADERS
        portmacro.h
    SOURCES
        port.c
)
