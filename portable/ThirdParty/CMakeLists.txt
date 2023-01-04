###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Partner Supported Ports
###############################################################################

###############################################################################
# AVR 8-bit ports
###############################################################################

set( PORT_DIR Partner-Supported-Ports/GCC/AVR_Mega0 )
freertos_define_port(NAME freertos_port_gcc_avr_mega0
                     ALIAS GCC_AVR_MEGA0
                     INCLUDE_DIR ${PORT_DIR}
                     HEADERS
                        ${PORT_DIR}/portmacro.h
                        ${PORT_DIR}/porthardware.h
                     SOURCES
                        ${PORT_DIR}/port.c )

set( PORT_DIR Partner-Supported-Ports/GCC/AVR_AVRDx )
freertos_define_port(NAME freertos_port_gcc_avr_avrdx
                     ALIAS GCC_AVRDX
                     INCLUDE_DIR ${PORT_DIR}
                     HEADERS
                        ${PORT_DIR}/portmacro.h
                        ${PORT_DIR}/porthardware.h
                     SOURCES
                        ${PORT_DIR}/port.c )


###############################################################################
# Community Supported Ports
###############################################################################

# TODO:
