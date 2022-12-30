###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# oWatcom Flsh186 for 16bit DOS
###############################################################################

freertos_define_port(
    NAME freertos_port_16bit_dos_flsh186
    ALIAS OWATCOM_16BIT_DOS_FLSH186
    HEADERS
        portmacro.h
    SOURCES
        port.c
)

target_link_libraries( freertos_port_16bit_dos_flsh186
    INTERFACE
        freertos_port_owatcom_16bit_dos_common )
