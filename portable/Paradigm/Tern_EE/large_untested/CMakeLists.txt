###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Paradigm Tern EE Large (Untested)
###############################################################################

freertos_define_port(
    NAME freertos_port_tern_ee_large
    ALIAS PARADIGM_TERN_EE_LARGE
    HEADERS
        portasm.h
        portmacro.h
    SOURCES
        port.c )
