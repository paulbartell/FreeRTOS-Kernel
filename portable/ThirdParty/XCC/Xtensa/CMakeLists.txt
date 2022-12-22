###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# XCC Xtensa
###############################################################################

freertos_define_port(
    NAME freertos_port_xcc_xtensa
    ALIAS XCC_XTENSA
    HEADERS
        portbenchmark.h
        portmacro.h
        porttrace.h
        xtensa_api.h
        xtensa_config.h
        xtensa_context.h
        xtensa_rtos.h
        xtensa_timer.h
    SOURCES
        portasm.S
        xtensa_context.S
        xtensa_intr_asm.S
        xtensa_vectors.S
        port.c
        portclib.c
        xtensa_init.c
        xtensa_intr.c
        xtensa_overlay_os_hook.c
)
