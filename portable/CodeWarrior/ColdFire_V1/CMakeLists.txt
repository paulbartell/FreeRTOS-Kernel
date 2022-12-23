###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ColdFire V1 for CodeWarrior
###############################################################################

freertos_define_port(
    NAME freertos_port_codewarrior_coldfire_v1
    ALIAS CODEWARRIOR_COLDFIRE_V1
    HEADERS
        portmacro.h
    SOURCES
        port.c
        portasm.S )
