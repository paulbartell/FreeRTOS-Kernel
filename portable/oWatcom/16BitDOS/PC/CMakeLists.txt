###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# oWatcom PC port for 16bit DOS
###############################################################################

freertos_define_port(
    NAME freertos_port_16bit_dos_pc
    ALIAS OWATCOM_16BIT_DOS_PC
    HEADERS
        portmacro.h
    SOURCES
        port.c
)

target_link_libraries( freertos_port_16bit_dos_pc
    INTERFACE
        freertos_port_owatcom_16bit_dos_common )
