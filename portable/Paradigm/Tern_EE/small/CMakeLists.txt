###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Paradigm Tern EE Small
###############################################################################

freertos_define_port(
    NAME freertos_port_tern_ee_small
    ALIAS PARADIGM_TERN_EE_SMALL
    HEADERS
        portasm.h
        portmacro.h
    SOURCES
        port.c
)
