###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Atmel SAM9XE for IAR
###############################################################################

freertos_define_port(
    NAME freertos_port_atmel_sam9xe
    ALIAS IAR_ATMEL_SAM9XE
    HEADERS
        portmacro.h
        ISR_Support.h
    SOURCES
        port.c
        portasm.s79 )
