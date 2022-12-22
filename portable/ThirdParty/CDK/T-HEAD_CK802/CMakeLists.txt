###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# T-HEAD_CK802
###############################################################################

freertos_define_port(
    NAME freertos_port_t-head_ck802
    ALIAS CDK_THEAD_CK802
    HEADERS
        portmacro.h
    SOURCES
        portasm.S
        port.c
)
