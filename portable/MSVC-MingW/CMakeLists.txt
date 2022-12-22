###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# MingW Port for MSVC
###############################################################################

freertos_define_port(
    NAME freertos_port_msvc_mingw
    ALIAS MSVC_MINGW MingW
    HEADERS
        portmacro.h
    SOURCES
        port.c
)
