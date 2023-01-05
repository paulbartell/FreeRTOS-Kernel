
###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Posix Port
###############################################################################

find_package(Threads REQUIRED)

freertos_define_port(
    NAME freertos_port_posix
    ALIAS GCC_POSIX Posix
    HEADERS
        portmacro.h
        utils/wait_for_event.h
    SOURCES
        port.c
        utils/wait_for_event.c )
