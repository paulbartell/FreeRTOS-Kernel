###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

macro(make_riscv_port EXT_NAME EXT_DIR ALIAS )
    freertos_define_port(
        NAME ${EXT_NAME}
        ALIAS ${ALIAS}
        HEADERS
            portmacro.h
            portContext.h
        SOURCES
            port.c
            portASM.S )

    if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
        target_sources( ${EXT_NAME}
            INTERFACE
                chip_specific_extensions/${EXT_DIR}/freertos_risc_v_chip_specific_extensions.h )
        target_include_directories( ${EXT_NAME}
            INTERFACE chip_specific_extensions/${EXT_DIR} )
    else()
        target_sources( ${EXT_NAME}
                PUBLIC
                    FILE_SET HEADERS
                        BASE_DIRS chip_specific_extensions/${EXT_DIR}
                        FILES freertos_risc_v_chip_specific_extensions.h )
    endif()
endmacro()

###############################################################################
# Generic GCC RISC-V
###############################################################################

make_riscv_port(freertos_port_riscv_no_extension
    RISCV_no_extensions
    GCC_RISC_V)

###############################################################################
# GCC RISC-V for Pulpino Vega RV32M1RM
###############################################################################

make_riscv_port(freertos_port_riscv_puplino_vega_rv32m1rm
    Pulpino_Vega_RV32M1RM
    GCC_RISC_V_PULPINO_VEGA_RV32M1RM)

# TODO: other 2 extensions