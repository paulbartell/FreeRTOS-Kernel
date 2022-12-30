###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# ppc405 for xilinx
###############################################################################

freertos_define_port(
    NAME freertos_port_ppc440_xilinx
    ALIAS GCC_PPC440_XILINX
    HEADERS
        portmacro.h
        FPU_Macros.h
    SOURCES
        port.c
        portasm.S )
