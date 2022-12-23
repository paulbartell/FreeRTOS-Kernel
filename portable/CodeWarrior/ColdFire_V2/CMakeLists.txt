###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ColdFire V2 for CodeWarrior
###############################################################################

freertos_define_port(
    NAME freertos_port_codewarrior_coldfire_v2
    ALIAS CODEWARRIOR_COLDFIRE_V2
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portasm.S )
