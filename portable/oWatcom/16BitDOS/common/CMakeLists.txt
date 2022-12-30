###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# oWatcom Common Files
###############################################################################

freertos_define_port(
    NAME freertos_port_owatcom_common
    COMMON_FILES
    ALIAS OWATCOM_COMMON
    HEADERS
        portasm.h
    SOURCES
        portcomn.c )
