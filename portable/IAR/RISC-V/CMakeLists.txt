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
            portASM.s )

    if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
        target_sources( ${EXT_NAME}
            INTERFACE
                chip_specific_extensions/${EXT_DIR}/freertos_risc_v_chip_specific_extensions.h )
        target_include_directories( ${EXT_NAME}
            INTERFACE chip_specific_extensions/${EXT_DIR} )
    else()
        target_sources( ${EXT_NAME}
                INTERFACE
                    FILE_SET HEADERS
                        BASE_DIRS chip_specific_extensions/${EXT_DIR}
                        FILES freertos_risc_v_chip_specific_extensions.h )
    endif()
endmacro()

###############################################################################
# IAR RISC-V for RV32I CLINT
###############################################################################

make_riscv_port(freertos_port_riscv_rv32i_clint
    RV32I_CLINT_no_extensions
    IAR_RISC_V_RV32I_CLINT)

# TODO: is this *really* a generic port?
add_library(FreeRTOS::Kernel::Port::IAR_RISC_V ALIAS freertos_port_riscv_rv32i_clint)