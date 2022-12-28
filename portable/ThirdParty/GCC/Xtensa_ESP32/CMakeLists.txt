###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Xtensa_ESP32
###############################################################################

freertos_define_port(
    NAME freertos_port_xtensa_esp32
    ALIAS GCC_XTENSA_ESP32
    HEADERS
        portmux_impl.h
        portmux_impl.inc.h
    SOURCES
        portasm.S
        xtensa_context.S
        xtensa_loadstore_handler.S
        xtensa_vector_defaults.S
        xtensa_vectors.S
        FreeRTOS-openocd.c
        port.c
        port_common.c
        port_systick.c
        xtensa_init.c
        xtensa_overlay_os_hook.c )
