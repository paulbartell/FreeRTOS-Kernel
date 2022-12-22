###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ARM7_LPC21xx
###############################################################################

message( FATAL_ERROR "Give ARM7_LPC21xx an alias and remove this message" )

freertos_define_port(
    NAME freertos_port_arm7_lpc21xx
    ALIAS # TODO:
    HEADERS
        portmacro.h
        portmacro.inc
    SOURCES
        portASM.s
        port.c
)
