###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# YOUR PORT
###############################################################################
message( FATAL_ERROR "Replace your_port with a port name and remove this message" )
freertos_define_port( 
    NAME your_port
    ALIAS YOUR_PORT
    HEADERS portmacro.h
    SOURCE
        portASM.S
        port.c )
