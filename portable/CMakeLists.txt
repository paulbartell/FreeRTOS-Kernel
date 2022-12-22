###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Export Heap Implementations as interface targets
###############################################################################
add_library( freertos_kernel_heap_1 INTERFACE MemMang/heap_1.c )
add_library( freertos_kernel_heap_2 INTERFACE MemMang/heap_2.c )
add_library( freertos_kernel_heap_3 INTERFACE MemMang/heap_3.c )
add_library( freertos_kernel_heap_4 INTERFACE MemMang/heap_4.c )

add_library( FreeRTOS::Kernel::Heap1 ALIAS freertos_kernel_heap_1 )
add_library( FreeRTOS::Kernel::Heap2 ALIAS freertos_kernel_heap_2 )
add_library( FreeRTOS::Kernel::Heap3 ALIAS freertos_kernel_heap_3 )
add_library( FreeRTOS::Kernel::Heap4 ALIAS freertos_kernel_heap_4 )

###############################################################################
# Helper for defining a port
# Useful for simple ports
###############################################################################
macro( freertos_define_port )
    set(oneValueArgs
        NAME    # current naming convention
        )

    set(multiValueArgs
        ALIAS     # backwards-compatible name(s)
        HEADERS   # header files this port uses
        SOURCES ) # source files this port uses

    cmake_parse_arguments(PORT "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if(PORT_NAME STREQUAL "")
        message( FATAL_ERROR "Provide a NAME for the port target!")
    endif()

    if(PORT_ALIAS STREQUAL "")
        message( FATAL_ERROR "Provide a backwards-compatible ALIAS for the port!")
    endif()

    list(FIND PORT_HEADERS "portmacro.h" index )
    if(index EQUAL -1)
        message( AUTHOR_WARNING "${PORT_NAME} does not have a portmacro.h" )
    endif()

    list(FIND PORT_SOURCES "port.c" index )
    if(index EQUAL -1)
        message( AUTHOR_WARNING "${PORT_NAME} does not have a port.c" )
    endif()

    message( STATUS "Configuring port ${PORT_NAME} AKA ${PORT_ALIAS}" )

    add_library( ${PORT_NAME} INTERFACE )

    target_sources( ${PORT_NAME} INTERFACE "${PORT_SOURCES}" )

    if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
        target_sources( ${PORT_NAME} PUBLIC "${PORT_HEADERS}" )
        target_include_directories( ${PORT_NAME} INTERFACE . )
    else()
        target_sources( ${PORT_NAME}
            PUBLIC
                FILE_SET HEADERS
                    BASE_DIRS .
                    FILES "${PORT_HEADERS}" )
    endif()

    foreach( ALIAS IN LISTS PORT_ALIAS )
        add_library( FreeRTOS::Kernel::Port::${ALIAS} ALIAS ${PORT_NAME} )
    endforeach()
    
endmacro()

###############################################################################
# Natively compiled simulator ports
###############################################################################
if(NOT CMAKE_CROSSCOMPILING)
    if(CMAKE_C_COMPILER_IS_CLANG OR CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory(ThirdParty/GCC/Posix)
    endif()

    if(CMAKE_C_COMPILER_IS_MSVC)
        # add_subdirectory(MSVC-MingW)
    endif()

###############################################################################
# 78K0R
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^78K$")
    if(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/78K0R )
    endif()

###############################################################################
# 8051 targets
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^8051$")
    if(CMAKE_C_COMPILER_IS_SDCC)
        # add_subdirectory( SDCC/Cygnal )
    endif()

###############################################################################
# ARC
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(ARC|arc).*$")
    if(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( ThirdParty/GCC/ARC_EM_HS )
        # add_subdirectory( ThirdParty/GCC/ARC_v1 )
    endif()

###############################################################################
# ARM targets
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM|Arm|arm")
    set( configKERNEL_INTERRUPT_PRIORITY 255 )
    set( configMAX_SYSCALL_INTERRUPT_PRIORITY 191 )

    # ARMv8-M IAR (EWARM), GCC, and Clang (including armclang and tiarmclang) ports
    # for Cortex-M23, Cortex-M33, Cortex-M55, Cortex-M85
    if(CMAKE_C_COMPILER_IS_CLANG OR CMAKE_C_COMPILER_IS_GCC OR CMAKE_C_COMPILER_IS_IAR)
        add_subdirectory( ARMv8M/non_secure )
        add_subdirectory( ARMv8M/secure )
    endif()

    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( ThirdParty/GCC/ARM_TFM )
    endif()

    # ARMv8-A ports for GNU/GCC and Clang (including armclang and tiarmclang)
    if(CMAKE_C_COMPILER_IS_CLANG OR CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/ARM_CA53_64_BIT )
        add_subdirectory( GCC/ARM_CA53_64_BIT_SRE )
    endif()

    ###########################################################################
    # ARMv7 and earlier ports for armcc versions 4 and 5
    # Compatible with Keil MDK, ARM DS-5, and ARM RVDS
    ###########################################################################
    if(CMAKE_C_COMPILER_IS_ARMCC)
        # # ARMv4T / ARM7TDMI
        # add_subdirectory( RVDS/ARM7_LPC21xx )

        # # ARMv7-A
        # add_subdirectory( RVDS/ARM_CA9 )

        # # ARMv6-M
        # add_subdirectory( RVDS/ARM_CM0 )

        # # ARMv7-M
        # add_subdirectory( RVDS/ARM_CM3 )

        # # ARMv7E-M
        # add_subdirectory( RVDS/ARM_CM4F )
        # add_subdirectory( RVDS/ARM_CM4_MPU )
        # add_subdirectory( RVDS/ARM_CM7/r0p1 )
    endif()

    ###########################################################################
    # ARMv7 and earlier ports for gcc
    # Compatible with gcc, clang, armclang and tiarmclang compilers
    ###########################################################################
    if(CMAKE_C_COMPILER_IS_CLANG OR CMAKE_C_COMPILER_IS_GCC)
        # ARMv4T / ARM7TDMI
        add_subdirectory( GCC/ARM7_AT91FR40008 )
        add_subdirectory( GCC/ARM7_AT91SAM7S )
        add_subdirectory( GCC/ARM7_LPC2000 )
        add_subdirectory( GCC/ARM7_LPC23xx )
        add_subdirectory( GCC/STR75x )

        # ARMv6-M
        add_subdirectory( GCC/ARM_CM0 )
        # add_subdirectory( ThirdParty/GCC/RP2040 )

        # ARMv7-M
        add_subdirectory( GCC/ARM_CM3 )
        add_subdirectory( GCC/ARM_CM3_MPU )

        # ARMv7E-M
        add_subdirectory( GCC/ARM_CM4F )
        add_subdirectory( GCC/ARM_CM4_MPU )
        add_subdirectory( GCC/ARM_CM7/r0p1 )

        # ARMv7-R
        add_subdirectory( GCC/ARM_CR5 )
        add_subdirectory( GCC/ARM_CRx_No_GIC )

        # ARMv7-A
        add_subdirectory( GCC/ARM_CA9 )
    endif()

    ###########################################################################
    # ARMv7 and earlier ports for the legacy TI CGT ARM compiler
    # Note: These ports should not be used with tiarmclang.
    ###########################################################################
    if(CMAKE_C_COMPILER_IS_TI_CGT)
        # TI CGT-ARM ARMv7-M
        # add_subdirectory( CCS/ARM_CM3 )

        # TI CGT-ARM ARMv7E-M
        # add_subdirectory( CCS/ARM_CM4F )

        # TI CGT-ARM ARMv7-R
        # add_subdirectory( CCS/ARM_Cortex-R4 )
    endif()

    if(CMAKE_C_COMPILER_IS_IAR)
        # # ARMv4T / ARM7TDMI
        # add_subdirectory( IAR/AtmelSAM7S64 )
        # add_subdirectory( IAR/LPC2000 )
        # add_subdirectory( IAR/STR71x )
        # add_subdirectory( IAR/STR75x )

        # # ARMv5T / ARM9TDMI
        # add_subdirectory( IAR/AtmelSAM9XE )
        # add_subdirectory( IAR/STR91x )

        # # ARMv7-A
        # add_subdirectory( IAR/ARM_CA5_No_GIC )
        # add_subdirectory( IAR/ARM_CA9 )

        # # ARMv6-M
        # add_subdirectory( IAR/ARM_CM0 )

        # # ARMv7-M
        # add_subdirectory( IAR/ARM_CM3 )

        # # ARMv7E-M
        # add_subdirectory( IAR/ARM_CM4F )
        # add_subdirectory( IAR/ARM_CM4F_MPU )
        # add_subdirectory( IAR/ARM_CM7 )

        # # ARMv7-R
        # add_subdirectory( IAR/ARM_CRx_No_GIC )
    endif()

    if(CMAKE_C_COMPILER_IS_TASKING)
        # add_subdirectory( Tasking/ARM_CM4F )
    endif()

    # TODO: MikroC/ARM_CM4F

###############################################################################
# Microchip / Atmel 8-bit AVR
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(AVR|avr)8?$")

    # GCC / Clang and compatible for 8-bit AVR
    if(CMAKE_C_COMPILER_IS_CLANG OR CMAKE_C_COMPILER_IS_GCC OR CMAKE_C_COMPILER_IS_MCHP_XC)
        add_subdirectory( GCC/ATMega323 )
        # add_subdirectory( ThirdParty/Partner-Supported-Ports/GCC/AVR_AVRDx )
        # add_subdirectory( ThirdParty/Partner-Supported-Ports/GCC/AVR_Mega0 )
        # add_subdirectory( ThirdParty/GCC/ATmega )

    # IAR for AVR8
    elseif(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/ATMega323 )
        # add_subdirectory( IAR/AVR_Mega0 )
        # add_subdirectory( IAR/AVR_AVRDx )
    endif()

###############################################################################
# Microchip / Atmel 32-bit AVR32
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(AVR|avr)32$")
    if(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( GCC/AVR32_UC3 )
    elseif(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/AVR32_UC3 )
    endif()

###############################################################################
# NXP / Freescale 32-bit ColdFire
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(m68k|M68K|coldfire|ColdFire|COLDFIRE)$")
    if(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( GCC/ColdFire_V2 )
    endif()
    # TODO: CodeWarrior/ColdFire_V1
    # TODO: CodeWarrior/ColdFire_V2

###############################################################################
# NXP / Freescale m68k derived 8-bit HC11 family (including HC11, HC12, HCS12)
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^m68hc1x$")
    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/HCS12 )
    endif()
    # TODO: CodeWarrior/HCS12

###############################################################################
# Xilinx 32-bit MicroBlaze
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(mblaze|MBLAZE|microblaze|MicroBlaze|MICROBLAZE).*$")
    # add_subdirectory( GCC/MicroBlaze )
    # add_subdirectory( GCC/MicroBlazeV8 )
    # add_subdirectory( GCC/MicroBlazeV9 )

###############################################################################
# 32-bit MIPS targets (including Microchip PIC32)
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(MIPS|mips).*$")
    # add_subdirectory( MPLAB/PIC32MEC14xx )
    # add_subdirectory( MPLAB/PIC32MX )
    # add_subdirectory( MPLAB/PIC32MZ )

###############################################################################
# 16-bit Texas Instruments MSP430
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(MSP|msp)?430$")
    if(CMAKE_C_COMPILER_IS_CLANG OR CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( GCC/MSP430F449 )
        # add_subdirectory( ThirdParty/Community-Supported-Ports/GCC/MSP430FR5969 )
    elseif(CMAKE_C_COMPILER_IS_TI_CGT)
        # add_subdirectory( CCS/MSP430X )
    elseif(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/MSP430 )
        # add_subdirectory( IAR/MSP430X )
    endif()
    # TODO: Rowley/MSP430F449

###############################################################################
# 16-bit Microchip PIC24
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(PIC24|pic24)$")
    if(CMAKE_C_COMPILER_IS_MCHP_XC)
        # add_subdirectory( MPLAB/PIC24_dsPIC )
    endif()

###############################################################################
# 8-bit Microchip PIC18
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(PIC18|pic18)[fF]?$")
    if(CMAKE_C_COMPILER_IS_MCHP_XC)
        # add_subdirectory( MPLAB/PIC18F )
    endif()

###############################################################################
# 32-Bit PowerPC
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(PPC|ppc).*$")
    # add_subdirectory( GCC/PPC405_Xilinx )
    # add_subdirectory( GCC/PPC440_Xilinx )

###############################################################################
# RISC-V
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(RISC-?V|risc-?v)$")
    if(CMAKE_C_COMPILER_IS_GCC OR CMAKE_C_COMPILER_IS_CLANG)
        # add_subdirectory( GCC/RISC-V )
    elseif(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/RISC-V )
    endif()

###############################################################################
# Renesas RL78 (Derived from 78K0R)
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(RL78|rl78)$")
    if(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( GCC/RL78 )
    elseif(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/RL78 )
    endif()

###############################################################################
# Renesas RX Architecture
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(RX|rx)$")
    if(CMAKE_C_COMPILER_IS_CCRX)
        # add_subdirectory( Renesas/RX100 )
        # add_subdirectory( Renesas/RX200 )
        # add_subdirectory( Renesas/RX600 )
        # add_subdirectory( Renesas/RX600v2 )
        # add_subdirectory( Renesas/RX700v3_DPFPU )

    elseif(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( GCC/RX100 )
        # add_subdirectory( GCC/RX200 )
        # add_subdirectory( GCC/RX600 )
        # add_subdirectory( GCC/RX600v2 )
        # add_subdirectory( GCC/RX700v3_DPFPU )

    elseif(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/RX100 )
        # add_subdirectory( IAR/RX600 )
        # add_subdirectory( IAR/RX700v3_DPFPU )
        # add_subdirectory( IAR/RXv2 )
    endif()

###############################################################################
# Renesas SuperH
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(SH|sh)$")
    # add_subdirectory( Renesas/SH2A_FPU )

###############################################################################
# Infineon TriCore
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(TRICORE|TriCore|tricore).*$")

    if(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( GCC/TriCore_1782 )
        # add_subdirectory( Community-Supported-Ports/GCC/TriCore_38xa )
    endif()

###############################################################################
# NEC / Renesas V850
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^v850.*$")
    if(CMAKE_C_COMPILER_IS_IAR)
        # add_subdirectory( IAR/V850ES )
    endif()

###############################################################################
# x86 / i386 / i686 Cross Compiled Targets
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86(_64)?|i.86)$")

    if(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( GCC/IA32_flat )

    elseif(CMAKE_C_COMPILER_IS_OPEN_WATCOM)
        # add_subdirectory( oWatcom/16BitDOS/Flsh186 )
        # add_subdirectory( oWatcom/16BitDOS/PC )

    elseif(CMAKE_C_COMPILER_IS_BORLAND)
        # add_subdirectory( BCC/16BitDOS/Flsh186 )
        # add_subdirectory( BCC/16BitDOS/PC )
    endif()

###############################################################################
# Xtensa targets
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(Xtensa|XTENSA|xtensa).*$")
    if(CMAKE_C_COMPILER_IS_GCC)
        # add_subdirectory( ThirdParty/GCC/Xtensa_ESP32 )
        # add_subdirectory( ThirdParty/XCC/Xtensa )
    endif()
else()

    # TODO: GCC/NiosII
    # TODO: GCC/CORTUS_APS3
    # TODO: GCC/H8S2329

endif()


# target_link_libraries(freertos_kernel_port
#     PUBLIC
#         $<$<STREQUAL:${FREERTOS_PORT},GCC_RP2040>:pico_base_headers>
#         $<$<STREQUAL:${FREERTOS_PORT},GCC_XTENSA_ESP32>:idf::esp32>
#     PRIVATE
#         freertos_kernel
#         "$<$<STREQUAL:${FREERTOS_PORT},GCC_RP2040>:hardware_clocks;hardware_exception>"
#         $<$<STREQUAL:${FREERTOS_PORT},MSVC_MINGW>:winmm> # Windows library which implements timers
# )
