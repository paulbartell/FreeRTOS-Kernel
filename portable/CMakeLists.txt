###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Export Heap Implementations as interface targets
###############################################################################
if(NOT FREERTOS_HEAP)
    foreach(i RANGE 1 5)
        add_library( freertos_kernel_heap_${i} INTERFACE MemMang/heap_${i}.c )
        add_library( FreeRTOS::Kernel:Heap${i} ALIAS freertos_kernel_heap_${i} )
    endforeach()
endif()

###############################################################################
# Helper for defining a port
# Useful for simple ports
###############################################################################
macro( freertos_define_port )
    set(optionalArgs
        COMMON_FILES ) # If set skips some checks
    set(oneValueArgs
        NAME )    # name to give to port library
    set(multiValueArgs
        ALIAS     # backwards-compatible name(s)
        HEADERS   # header files this port uses
        SOURCES ) # source files this port uses
    cmake_parse_arguments(PORT
        "${optionalArgs}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN} )

    if( PORT_NAME STREQUAL "" )
        message( FATAL_ERROR "Provide a NAME for the port target!")
    endif()
    if( PORT_ALIAS STREQUAL "" )
        message( FATAL_ERROR
        "Provide a backwards-compatible ALIAS for the port!")
    endif()

    message( STATUS "Configuring port ${PORT_NAME} AKA ${PORT_ALIAS}" )

    if(NOT PORT_COMMON_FILES)
        if( ( NOT "portmacro.h" IN_LIST PORT_HEADERS ) AND
            ( NOT "prtmacro.h"  IN_LIST PORT_HEADERS ) ) # BCC 16bitdos
            message( AUTHOR_WARNING
            "${PORT_NAME} does not have a portmacro.h under HEADERS" )
        endif()
        if(NOT "port.c" IN_LIST PORT_SOURCES)
            message( AUTHOR_WARNING
            "${PORT_NAME} does not have a port.c under SOURCES" )
        endif()
    endif()

    add_library( ${PORT_NAME} INTERFACE )

    target_sources( ${PORT_NAME} INTERFACE ${PORT_SOURCES} )

    if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
        target_sources( ${PORT_NAME} PUBLIC ${PORT_HEADERS} )
        target_include_directories( ${PORT_NAME} INTERFACE . )
    else()
        target_sources( ${PORT_NAME}
            PUBLIC
                FILE_SET HEADERS
                    BASE_DIRS .
                    FILES ${PORT_HEADERS} )
    endif()

    foreach( ALIAS IN LISTS PORT_ALIAS )
        add_library( FreeRTOS::Kernel::Port::${ALIAS} ALIAS ${PORT_NAME} )
    endforeach()
endmacro()

###############################################################################
# Backwards-compatibility
###############################################################################
if(FREERTOS_PORT)
    if(FREERTOS_PORT STREQUAL "A_CUSTOM_PORT")
        # freertos_kernel_port ought to already be defined
        return()
    endif()

    if(FREERTOS_PORT STREQUAL "MSVC_MINGW")
        add_subdirectory( MSVC-MingW )

    elseif(FREERTOS_PORT STREQUAL "GCC_POSIX")
        add_subdirectory( ThirdParty/GCC/Posix )

    elseif(FREERTOS_PORT STREQUAL "GCC_IA32_FLAT")
        add_subdirectory( GCC/IA32_flat )

    elseif(FREERTOS_PORT MATCHES "(OWATCOM|BCC)_16BIT_DOS_(PC|FLSH186)")
        if(${CMAKE_MATCH_1} STREQUAL BCC)
            set( MATCH_COMPILER BCC )
        else()
            set( MATCH_COMPILER oWatcom )
        endif()
        add_subdirectory( ${MATCH_COMPILER}/16BitDOS/common )
        add_subdirectory( ${MATCH_COMPILER}/16BitDOS/Flsh186 )
        add_subdirectory( ${MATCH_COMPILER}/16BitDOS/PC )

    elseif(FREERTOS_PORT MATCHES "^(GCC|IAR)_ARM_CM(23|33|55|85)_(NONSECURE|SECURE|TFM|NTZ_NONSECURE)$")
        add_subdirectory( ARMv8M/non_secure )
        add_subdirectory( ARMv8M/secure )

    elseif(FREERTOS_PORT MATCHES "^(GCC|IAR|RDVS)_ARM_CM7$" )
        add_subdirectory( ${CMAKE_MATCH_1}/ARM_CM7/r0p1 )

    elseif(FREERTOS_PORT MATCHES "^(GCC|IAR)_ARM_(CRX|CA5)_NOGIC$")
        if(${CMAKE_MATCH_2} STREQUAL "CRX")
            add_subdirectory( ${CMAKE_MATCH_1}/ARM_CRx_No_GIC )
        else()
            add_subdirectory( ${CMAKE_MATCH_1}/ARM_CA5_No_GIC )
        endif()

    elseif(FREERTOS_PORT MATCHES "^(GCC|IAR)_COLDFIRE_(V1|V2)$")
        add_subdirectory( ${CMAKE_MATCH_1}/MicroBlaze_${CMAKE_MATCH_2} )

    elseif(FREERTOS_PORT MATCHES "^GCC_MICROBLAZE_?(V8|V9)?$")
        add_subdirectory( GCC/MicroBlaze${CMAKE_MATCH_1} )

    elseif(FREERTOS_PORT MATCHES "GCC_RISC_V")
        add_subdirectory(GCC/RISC-V)

    elseif(FREERTOS_PORT MATCHES "(IAR|CCS)_MSP430(X)?")
        add_subdirectory( ${CMAKE_MATCH_1}/MSP430${CMAKE_MATCH_2} )

    elseif(FREERTOS_PORT MATCHES "(GCC|ROWLEY)_MSP430F449")
        add_subdirectory( ${CMAKE_MATCH_1}/MSP430F449 )

    elseif(FREERTOS_PORT MATCHES "^([A-Z\\d]+)_(.*)$" ) # fallback
        message( STATUS "Falling back to ${CMAKE_MATCH_1}/${CMAKE_MATCH_2}" )
        add_subdirectory( ${CMAKE_MATCH_1}/${CMAKE_MATCH_2} )
    endif()

    if( NOT TARGET FreeRTOS::Kernel::Port::${FREERTOS_PORT} )
        message( WARNING " Port ${FREERTOS_PORT} not found.\n"
        " Available port options:\n"
        " A_CUSTOM_PORT                    - Compiler: User Defined  Target: User Defined\n"
        " BCC_16BIT_DOS_FLSH186            - Compiler: BCC           Target: 16 bit DOS Flsh186\n"
        " BCC_16BIT_DOS_PC                 - Compiler: BCC           Target: 16 bit DOS PC\n"
        " CCS_ARM_CM3                      - Compiler: CCS           Target: ARM Cortex-M3\n"
        " CCS_ARM_CM4F                     - Compiler: CCS           Target: ARM Cortex-M4 with FPU\n"
        " CCS_ARM_CR4                      - Compiler: CCS           Target: ARM Cortex-R4\n"
        " CCS_MSP430X                      - Compiler: CCS           Target: MSP430X\n"
        " CODEWARRIOR_COLDFIRE_V1          - Compiler: CoreWarrior   Target: ColdFire V1\n"
        " CODEWARRIOR_COLDFIRE_V2          - Compiler: CoreWarrior   Target: ColdFire V2\n"
        " CODEWARRIOR_HCS12                - Compiler: CoreWarrior   Target: HCS12\n"
        " GCC_ARM_CA9                      - Compiler: GCC           Target: ARM Cortex-A9\n"
        " GCC_ARM_CA53_64_BIT              - Compiler: GCC           Target: ARM Cortex-A53 64 bit\n"
        " GCC_ARM_CA53_64_BIT_SRE          - Compiler: GCC           Target: ARM Cortex-A53 64 bit SRE\n"
        " GCC_ARM_CM0                      - Compiler: GCC           Target: ARM Cortex-M0\n"
        " GCC_ARM_CM3                      - Compiler: GCC           Target: ARM Cortex-M3\n"
        " GCC_ARM_CM3_MPU                  - Compiler: GCC           Target: ARM Cortex-M3 with MPU\n"
        " GCC_ARM_CM4_MPU                  - Compiler: GCC           Target: ARM Cortex-M4 with MPU\n"
        " GCC_ARM_CM4F                     - Compiler: GCC           Target: ARM Cortex-M4 with FPU\n"
        " GCC_ARM_CM7                      - Compiler: GCC           Target: ARM Cortex-M7\n"
        " GCC_ARM_CM23_NONSECURE           - Compiler: GCC           Target: ARM Cortex-M23 non-secure\n"
        " GCC_ARM_CM23_SECURE              - Compiler: GCC           Target: ARM Cortex-M23 secure\n"
        " GCC_ARM_CM23_NTZ_NONSECURE       - Compiler: GCC           Target: ARM Cortex-M23 non-trustzone non-secure\n"
        " GCC_ARM_CM33_NONSECURE           - Compiler: GCC           Target: ARM Cortex-M33 non-secure\n"
        " GCC_ARM_CM33_SECURE              - Compiler: GCC           Target: ARM Cortex-M33 secure\n"
        " GCC_ARM_CM33_NTZ_NONSECURE       - Compiler: GCC           Target: ARM Cortex-M33 non-trustzone non-secure\n"
        " GCC_ARM_CM33_TFM                 - Compiler: GCC           Target: ARM Cortex-M33 non-secure for TF-M\n"
        " GCC_ARM_CM55_NONSECURE           - Compiler: GCC           Target: ARM Cortex-M55 non-secure\n"
        " GCC_ARM_CM55_SECURE              - Compiler: GCC           Target: ARM Cortex-M55 secure\n"
        " GCC_ARM_CM55_NTZ_NONSECURE       - Compiler: GCC           Target: ARM Cortex-M55 non-trustzone non-secure\n"
        " GCC_ARM_CM55_TFM                 - Compiler: GCC           Target: ARM Cortex-M55 non-secure for TF-M\n"
        " GCC_ARM_CM85_NONSECURE           - Compiler: GCC           Target: ARM Cortex-M85 non-secure\n"
        " GCC_ARM_CM85_SECURE              - Compiler: GCC           Target: ARM Cortex-M85 secure\n"
        " GCC_ARM_CM85_NTZ_NONSECURE       - Compiler: GCC           Target: ARM Cortex-M85 non-trustzone non-secure\n"
        " GCC_ARM_CM85_TFM                 - Compiler: GCC           Target: ARM Cortex-M85 non-secure for TF-M\n"
        " GCC_ARM_CR5                      - Compiler: GCC           Target: ARM Cortex-R5\n"
        " GCC_ARM_CRX_NOGIC                - Compiler: GCC           Target: ARM Cortex-Rx no GIC\n"
        " GCC_ARM7_AT91FR40008             - Compiler: GCC           Target: ARM7 Atmel AT91R40008\n"
        " GCC_ARM7_AT91SAM7S               - Compiler: GCC           Target: ARM7 Atmel AT91SAM7S\n"
        " GCC_ARM7_LPC2000                 - Compiler: GCC           Target: ARM7 LPC2000\n"
        " GCC_ARM7_LPC23XX                 - Compiler: GCC           Target: ARM7 LPC23xx\n"
        " GCC_ATMEGA323                    - Compiler: GCC           Target: ATMega323\n"
        " GCC_AVR32_UC3                    - Compiler: GCC           Target: AVR32 UC3\n"
        " GCC_COLDFIRE_V2                  - Compiler: GCC           Target: ColdFire V2\n"
        " GCC_CORTUS_APS3                  - Compiler: GCC           Target: CORTUS APS3\n"
        " GCC_H8S2329                      - Compiler: GCC           Target: H8S2329\n"
        " GCC_HCS12                        - Compiler: GCC           Target: HCS12\n"
        " GCC_IA32_FLAT                    - Compiler: GCC           Target: IA32 flat\n"
        " GCC_MICROBLAZE                   - Compiler: GCC           Target: MicroBlaze\n"
        " GCC_MICROBLAZE_V8                - Compiler: GCC           Target: MicroBlaze V8\n"
        " GCC_MICROBLAZE_V9                - Compiler: GCC           Target: MicroBlaze V9\n"
        " GCC_MSP430F449                   - Compiler: GCC           Target: MSP430F449\n"
        " GCC_NIOSII                       - Compiler: GCC           Target: NiosII\n"
        " GCC_PPC405_XILINX                - Compiler: GCC           Target: Xilinx PPC405\n"
        " GCC_PPC440_XILINX                - Compiler: GCC           Target: Xilinx PPC440\n"
        " GCC_RISC_V                       - Compiler: GCC           Target: RISC-V\n"
        " GCC_RISC_V_PULPINO_VEGA_RV32M1RM - Compiler: GCC           Target: RISC-V Pulpino Vega RV32M1RM\n"
        " GCC_RL78                         - Compiler: GCC           Target: Renesas RL78\n"
        " GCC_RX100                        - Compiler: GCC           Target: Renesas RX100\n"
        " GCC_RX200                        - Compiler: GCC           Target: Renesas RX200\n"
        " GCC_RX600                        - Compiler: GCC           Target: Renesas RX600\n"
        " GCC_RX600_V2                     - Compiler: GCC           Target: Renesas RX600 v2\n"
        " GCC_RX700_V3_DPFPU               - Compiler: GCC           Target: Renesas RX700 v3 with DPFPU\n"
        " GCC_STR75X                       - Compiler: GCC           Target: STR75x\n"
        " GCC_TRICORE_1782                 - Compiler: GCC           Target: TriCore 1782\n"
        " GCC_ARC_EM_HS                    - Compiler: GCC           Target: DesignWare ARC EM HS\n"
        " GCC_ARC_V1                       - Compiler: GCC           Target: DesignWare ARC v1\n"
        " GCC_ATMEGA                       - Compiler: GCC           Target: ATmega\n"
        " GCC_POSIX                        - Compiler: GCC           Target: Posix\n"
        " GCC_RP2040                       - Compiler: GCC           Target: RP2040 ARM Cortex-M0+\n"
        " GCC_XTENSA_ESP32                 - Compiler: GCC           Target: Xtensa ESP32\n"
        " GCC_AVRDX                        - Compiler: GCC           Target: AVRDx\n"
        " GCC_AVR_MEGA0                    - Compiler: GCC           Target: AVR Mega0\n"
        " IAR_78K0K                        - Compiler: IAR           Target: Renesas 78K0K\n"
        " IAR_ARM_CA5_NOGIC                - Compiler: IAR           Target: ARM Cortex-A5 no GIC\n"
        " IAR_ARM_CA9                      - Compiler: IAR           Target: ARM Cortex-A9\n"
        " IAR_ARM_CM0                      - Compiler: IAR           Target: ARM Cortex-M0\n"
        " IAR_ARM_CM3                      - Compiler: IAR           Target: ARM Cortex-M3\n"
        " IAR_ARM_CM4F                     - Compiler: IAR           Target: ARM Cortex-M4 with FPU\n"
        " IAR_ARM_CM4F_MPU                 - Compiler: IAR           Target: ARM Cortex-M4 with FPU and MPU\n"
        " IAR_ARM_CM7                      - Compiler: IAR           Target: ARM Cortex-M7\n"
        " IAR_ARM_CM23_NONSECURE           - Compiler: IAR           Target: ARM Cortex-M23 non-secure\n"
        " IAR_ARM_CM23_SECURE              - Compiler: IAR           Target: ARM Cortex-M23 secure\n"
        " IAR_ARM_CM23_NTZ_NONSECURE       - Compiler: IAR           Target: ARM Cortex-M23 non-trustzone non-secure\n"
        " IAR_ARM_CM33_NONSECURE           - Compiler: IAR           Target: ARM Cortex-M33 non-secure\n"
        " IAR_ARM_CM33_SECURE              - Compiler: IAR           Target: ARM Cortex-M33 secure\n"
        " IAR_ARM_CM33_NTZ_NONSECURE       - Compiler: IAR           Target: ARM Cortex-M33 non-trustzone non-secure\n"
        " IAR_ARM_CM55_NONSECURE           - Compiler: IAR           Target: ARM Cortex-M55 non-secure\n"
        " IAR_ARM_CM55_SECURE              - Compiler: IAR           Target: ARM Cortex-M55 secure\n"
        " IAR_ARM_CM55_NTZ_NONSECURE       - Compiler: IAR           Target: ARM Cortex-M55 non-trustzone non-secure\n"
        " IAR_ARM_CM85_NONSECURE           - Compiler: IAR           Target: ARM Cortex-M85 non-secure\n"
        " IAR_ARM_CM85_SECURE              - Compiler: IAR           Target: ARM Cortex-M85 secure\n"
        " IAR_ARM_CM85_NTZ_NONSECURE       - Compiler: IAR           Target: ARM Cortex-M85 non-trustzone non-secure\n"
        " IAR_ARM_CRX_NOGIC                - Compiler: IAR           Target: ARM Cortex-Rx no GIC\n"
        " IAR_ATMEGA323                    - Compiler: IAR           Target: ATMega323\n"
        " IAR_ATMEL_SAM7S64                - Compiler: IAR           Target: Atmel SAM7S64\n"
        " IAR_ATMEL_SAM9XE                 - Compiler: IAR           Target: Atmel SAM9XE\n"
        " IAR_AVR_AVRDX                    - Compiler: IAR           Target: AVRDx\n"
        " IAR_AVR_MEGA0                    - Compiler: IAR           Target: AVR Mega0\n"
        " IAR_AVR32_UC3                    - Compiler: IAR           Target: AVR32 UC3\n"
        " IAR_LPC2000                      - Compiler: IAR           Target: LPC2000\n"
        " IAR_MSP430                       - Compiler: IAR           Target: MSP430\n"
        " IAR_MSP430X                      - Compiler: IAR           Target: MSP430X\n"
        " IAR_RISC_V                       - Compiler: IAR           Target: RISC-V\n"
        " IAR_RL78                         - Compiler: IAR           Target: Renesas RL78\n"
        " IAR_RX100                        - Compiler: IAR           Target: Renesas RX100\n"
        " IAR_RX600                        - Compiler: IAR           Target: Renesas RX600\n"
        " IAR_RX700_V3_DPFPU               - Compiler: IAR           Target: Renesas RX700 v3 with DPFPU\n"
        " IAR_RX_V2                        - Compiler: IAR           Target: Renesas RX v2\n"
        " IAR_STR71X                       - Compiler: IAR           Target: STR71x\n"
        " IAR_STR75X                       - Compiler: IAR           Target: STR75x\n"
        " IAR_STR91X                       - Compiler: IAR           Target: STR91x\n"
        " IAR_V850ES_FX3                   - Compiler: IAR           Target: Renesas V850ES/Fx3\n"
        " IAR_V850ES_HX3                   - Compiler: IAR           Target: Renesas V850ES/Hx3\n"
        " MIKROC_ARM_CM4F                  - Compiler: MikroC        Target: ARM Cortex-M4 with FPU\n"
        " MPLAB_PIC18F                     - Compiler: MPLAB         Target: PIC18F\n"
        " MPLAB_PIC24                      - Compiler: MPLAB         Target: PIC24\n"
        " MPLAB_PIC32MEC14XX               - Compiler: MPLAB         Target: PIC32MEC14xx\n"
        " MPLAB_PIC32MX                    - Compiler: MPLAB         Target: PIC32MX\n"
        " MPLAB_PIC32MZ                    - Compiler: MPLAB         Target: PIC32MZ\n"
        " MSVC_MINGW                       - Compiler: MSVC or MinGW Target: x86\n"
        " OWATCOM_16BIT_DOS_FLSH186        - Compiler: Open Watcom   Target: 16 bit DOS Flsh186\n"
        " OWATCOM_16BIT_DOS_PC             - Compiler: Open Watcom   Target: 16 bit DOS PC\n"
        " PARADIGM_TERN_EE_LARGE           - Compiler: Paradigm      Target: Tern EE large\n"
        " PARADIGM_TERN_EE_SMALL           - Compiler: Paradigm      Target: Tern EE small\n"
        " RENESAS_RX100                    - Compiler: Renesas       Target: RX100\n"
        " RENESAS_RX200                    - Compiler: Renesas       Target: RX200\n"
        " RENESAS_RX600                    - Compiler: Renesas       Target: RX600\n"
        " RENESAS_RX600_V2                 - Compiler: Renesas       Target: RX600 v2\n"
        " RENESAS_RX700_V3_DPFPU           - Compiler: Renesas       Target: RX700 v3 with DPFPU\n"
        " RENESAS_SH2A_FPU                 - Compiler: Renesas       Target: SH2A with FPU\n"
        " ROWLEY_MSP430F449                - Compiler: Rowley        Target: MSP430F449\n"
        " RVDS_ARM_CA9                     - Compiler: RVDS          Target: ARM Cortex-A9\n"
        " RVDS_ARM_CM0                     - Compiler: RVDS          Target: ARM Cortex-M0\n"
        " RVDS_ARM_CM3                     - Compiler: RVDS          Target: ARM Cortex-M3\n"
        " RVDS_ARM_CM4_MPU                 - Compiler: RVDS          Target: ARM Cortex-M4 with MPU\n"
        " RVDS_ARM_CM4F                    - Compiler: RVDS          Target: ARM Cortex-M4 with FPU\n"
        " RVDS_ARM_CM7                     - Compiler: RVDS          Target: ARM Cortex-M7\n"
        " RVDS_ARM7_LPC21XX                - Compiler: RVDS          Target: ARM7 LPC21xx\n"
        " SDCC_CYGNAL                      - Compiler: SDCC          Target: Cygnal\n"
        " SOFTUNE_MB91460                  - Compiler: Softune       Target: MB91460\n"
        " SOFTUNE_MB96340                  - Compiler: Softune       Target: MB96340\n"
        " TASKING_ARM_CM4F                 - Compiler: Tasking       Target: ARM Cortex-M4 with FPU\n"
        " CDK_THEAD_CK802                  - Compiler: CDK           Target: T-head CK802\n"
        " XCC_XTENSA                       - Compiler: XCC           Target: Xtensa\n"
        " WIZC_PIC18                       - Compiler: WizC          Target: PIC18" )

        return()
    endif()

    get_target_property(target_name
        FreeRTOS::Kernel::Port::${FREERTOS_PORT}
        ALIASED_TARGET )
    add_library(freertos_kernel_port ALIAS ${target_name})

    return()
endif()

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
        add_subdirectory( IAR/78K0R )
    endif()

###############################################################################
# 8051 targets
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^8051$")
    if(CMAKE_C_COMPILER_IS_SDCC)
        add_subdirectory( SDCC/Cygnal )
    endif()

###############################################################################
# ARC
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(ARC|arc).*$")
    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( ThirdParty/GCC/ARC_EM_HS )
        add_subdirectory( ThirdParty/GCC/ARC_v1 )
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
        add_subdirectory( RVDS/ARM7_LPC21xx )

        # # ARMv7-A
        add_subdirectory( RVDS/ARM_CA9 )

        # # ARMv6-M
        add_subdirectory( RVDS/ARM_CM0 )

        # # ARMv7-M
        add_subdirectory( RVDS/ARM_CM3 )

        # # ARMv7E-M
        add_subdirectory( RVDS/ARM_CM4F )
        add_subdirectory( RVDS/ARM_CM4_MPU )
        add_subdirectory( RVDS/ARM_CM7/r0p1 )
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
        add_subdirectory( CCS/ARM_CM3 )

        # TI CGT-ARM ARMv7E-M
        add_subdirectory( CCS/ARM_CM4F )

        # TI CGT-ARM ARMv7-R
        add_subdirectory( CCS/ARM_Cortex-R4 )
    endif()

    if(CMAKE_C_COMPILER_IS_IAR)
        # # ARMv4T / ARM7TDMI
        add_subdirectory( IAR/AtmelSAM7S64 )
        add_subdirectory( IAR/LPC2000 )
        add_subdirectory( IAR/STR71x )
        add_subdirectory( IAR/STR75x )

        # # ARMv5T / ARM9TDMI
        add_subdirectory( IAR/AtmelSAM9XE )
        add_subdirectory( IAR/STR91x )

        # # ARMv7-A
        add_subdirectory( IAR/ARM_CA5_No_GIC )
        add_subdirectory( IAR/ARM_CA9 )

        # # ARMv6-M
        add_subdirectory( IAR/ARM_CM0 )

        # # ARMv7-M
        add_subdirectory( IAR/ARM_CM3 )

        # # ARMv7E-M
        add_subdirectory( IAR/ARM_CM4F )
        add_subdirectory( IAR/ARM_CM4F_MPU )
        add_subdirectory( IAR/ARM_CM7/r0p1 )

        # # ARMv7-R
        add_subdirectory( IAR/ARM_CRx_No_GIC )
    endif()

    if(CMAKE_C_COMPILER_IS_TASKING)
        add_subdirectory( Tasking/ARM_CM4F )
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
        add_subdirectory( ThirdParty/GCC/ATmega )

    # IAR for AVR8
    elseif(CMAKE_C_COMPILER_IS_IAR)
        add_subdirectory( IAR/ATMega323 )
        add_subdirectory( IAR/AVR_Mega0 )
        add_subdirectory( IAR/AVR_AVRDx )
    endif()

###############################################################################
# Microchip / Atmel 32-bit AVR32
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(AVR|avr)32$")
    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/AVR32_UC3 )
    elseif(CMAKE_C_COMPILER_IS_IAR)
        add_subdirectory( IAR/AVR32_UC3 )
    endif()

###############################################################################
# NXP / Freescale 32-bit ColdFire
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(m68k|M68K|coldfire|ColdFire|COLDFIRE)$")
    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/ColdFire_V2 )
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
    add_subdirectory( GCC/MicroBlaze )
    add_subdirectory( GCC/MicroBlazeV8 )
    add_subdirectory( GCC/MicroBlazeV9 )

###############################################################################
# 32-bit MIPS targets (including Microchip PIC32)
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(MIPS|mips).*$")
    add_subdirectory( MPLAB/PIC32MEC14xx )
    add_subdirectory( MPLAB/PIC32MX )
    add_subdirectory( MPLAB/PIC32MZ )

###############################################################################
# 16-bit Texas Instruments MSP430
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(MSP|msp)?430$")
    if(CMAKE_C_COMPILER_IS_CLANG OR CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/MSP430F449 )
        # add_subdirectory( ThirdParty/Community-Supported-Ports/GCC/MSP430FR5969 )
    elseif(CMAKE_C_COMPILER_IS_TI_CGT)
        add_subdirectory( CCS/MSP430X )
    elseif(CMAKE_C_COMPILER_IS_IAR)
        add_subdirectory( IAR/MSP430 )
        add_subdirectory( IAR/MSP430X )
    endif()
    # TODO: Rowley/MSP430F449

###############################################################################
# 16-bit Microchip PIC24
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(PIC24|pic24)$")
    if(CMAKE_C_COMPILER_IS_MCHP_XC)
        add_subdirectory( MPLAB/PIC24_dsPIC )
    endif()

###############################################################################
# 8-bit Microchip PIC18
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(PIC18|pic18)[fF]?$")
    if(CMAKE_C_COMPILER_IS_MCHP_XC)
        add_subdirectory( MPLAB/PIC18F )
    endif()

###############################################################################
# 32-Bit PowerPC
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(PPC|ppc).*$")
    add_subdirectory( GCC/PPC405_Xilinx )
    add_subdirectory( GCC/PPC440_Xilinx )

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
        add_subdirectory( GCC/RL78 )
    elseif(CMAKE_C_COMPILER_IS_IAR)
        add_subdirectory( IAR/RL78 )
    endif()

###############################################################################
# Renesas RX Architecture
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(RX|rx)$")
    if(CMAKE_C_COMPILER_IS_CCRX)
        add_subdirectory( Renesas/RX100 )
        add_subdirectory( Renesas/RX200 )
        add_subdirectory( Renesas/RX600 )
        add_subdirectory( Renesas/RX600v2 )
        add_subdirectory( Renesas/RX700v3_DPFPU )

    elseif(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/RX100 )
        add_subdirectory( GCC/RX200 )
        add_subdirectory( GCC/RX600 )
        add_subdirectory( GCC/RX600v2 )
        add_subdirectory( GCC/RX700v3_DPFPU )

    elseif(CMAKE_C_COMPILER_IS_IAR)
        add_subdirectory( IAR/RX100 )
        add_subdirectory( IAR/RX600 )
        add_subdirectory( IAR/RX700v3_DPFPU )
        add_subdirectory( IAR/RXv2 )
    endif()

###############################################################################
# Renesas SuperH
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(SH|sh)$")
    add_subdirectory( Renesas/SH2A_FPU )

###############################################################################
# Infineon TriCore
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(TRICORE|TriCore|tricore).*$")

    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/TriCore_1782 )
        # add_subdirectory( Community-Supported-Ports/GCC/TriCore_38xa )
    endif()

###############################################################################
# NEC / Renesas V850
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^v850.*$")
    if(CMAKE_C_COMPILER_IS_IAR)
        add_subdirectory( IAR/V850ES )
    endif()

###############################################################################
# x86 / i386 / i686 Cross Compiled Targets
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86(_64)?|i.86)$")

    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( GCC/IA32_flat )

    elseif(CMAKE_C_COMPILER_IS_OPEN_WATCOM)
        add_subdirectory( oWatcom/16BitDOS/Flsh186 )
        add_subdirectory( oWatcom/16BitDOS/PC )

    elseif(CMAKE_C_COMPILER_IS_BORLAND)
        add_subdirectory( BCC/16BitDOS/Flsh186 )
        add_subdirectory( BCC/16BitDOS/PC )
    endif()

###############################################################################
# Xtensa targets
###############################################################################
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(Xtensa|XTENSA|xtensa).*$")
    if(CMAKE_C_COMPILER_IS_GCC)
        add_subdirectory( ThirdParty/GCC/Xtensa_ESP32 )
        add_subdirectory( ThirdParty/XCC/Xtensa )
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
