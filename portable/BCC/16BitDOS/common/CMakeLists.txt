###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Common Files for BCC 16bit DOS
###############################################################################

freertos_define_port(
    NAME freertos_port_16bit_dos_common
    ALIAS BCC_16BIT_DOS_COMMON
    COMMON_FILES
    HEADERS
        portasm.h
    SOURCES
        portcomn.c )
