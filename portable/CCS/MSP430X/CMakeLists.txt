###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# CCS MSP430X
###############################################################################

freertos_define_port(
    NAME freertos_port_msp430x
    ALIAS
        CCS_MSP430X
    HEADERS
        portmacro.h
        data_model.h
    SOURCES
        port.c
        portext.asm )
