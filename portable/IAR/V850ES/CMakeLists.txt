###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# IAR V850ES Fx3
###############################################################################

freertos_define_port(
    NAME freertos_port_v840es_fx3
    ALIAS IAR_V850ES_FX3
    HEADERS
        portmacro.h
        ISR_Support.h
    SOURCES
        port.c
        portasm.s85
        portasm_Fx3.s85 )

###############################################################################
# IAR V850ES Hx3
###############################################################################

freertos_define_port(
    NAME freertos_port_v840es_hx3
    ALIAS IAR_V850ES_HX3
    HEADERS
        portmacro.h
        ISR_Support.h
    SOURCES
        port.c
        portasm.s85
        portasm_Hx2.s85 )
