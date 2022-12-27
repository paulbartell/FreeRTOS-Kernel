###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

cmake_minimum_required(VERSION 3.16)
project(FreeRTOS-Kernel C ASM)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

###############################################################################
# Detect target toolchain / compiler
###############################################################################
string(TOLOWER "${CMAKE_C_COMPILER_ID}" C_COMPILER_ID_LOWER)

# ARM Compiler 4 and 5 (RVDS)
if(C_COMPILER_ID_LOWER MATCHES "armcc")
    set(CMAKE_C_COMPILER_IS_ARMCC TRUE)
endif()

# llvm-clang and variants including armclang and tiarmclang
if(C_COMPILER_ID_LOWER MATCHES "clang")
    set(CMAKE_C_COMPILER_IS_CLANG TRUE)
endif()

# gnu/gcc derived toolchains
if(C_COMPILER_ID_LOWER MATCHES "gnu|gcc")
    set(CMAKE_C_COMPILER_IS_GCC TRUE)
endif()

# IAR ew/bx toolchains
# ewarm, bxarm, ewavr, ewarv32, ew430, ewriscv, bxriscv, ewrl78, bxrl78, ewv850
if(C_COMPILER_ID_LOWER MATCHES "iar")
    set(CMAKE_C_COMPILER_IS_IAR TRUE)
endif()

# Microsoft Visual C Compiler (MSVC)
if(C_COMPILER_ID_LOWER MATCHES "msvc")
    set(CMAKE_C_COMPILER_IS_MSVC TRUE)
endif()

# Microchip XC8, XC16, and XC32 compilers (MPLAB)
if(C_COMPILER_ID_LOWER MATCHES "xc8|xc8cc|xc16|xc32")
    set(CMAKE_C_COMPILER_IS_MCHP_XC TRUE)
endif()

# TI CGT-MSP430, CGT-ARM (CCS)
if(C_COMPILER_ID_LOWER MATCHES "ti" AND NOT CMAKE_C_COMPILER_IS_CLANG)
    set(CMAKE_C_COMPILER_IS_TI_CGT TRUE)
endif()

# Renesas CCRX / rxc compiler for RX architecture
if(C_COMPILER_ID_LOWER MATCHES "rxc")
    set(CMAKE_C_COMPILER_IS_CCRX TRUE)
endif()

# Small Device C Compiler
if(C_COMPILER_ID_LOWER MATCHES "sdcc")
    set(CMAKE_C_COMPILER_IS_SDCC TRUE)
endif()

# OpenWatcom bare metal x68 / dos compiler
if(C_COMPILER_ID_LOWER MATCHES "openwatcom")
    set(CMAKE_C_COMPILER_IS_OPEN_WATCOM TRUE)
endif()

# Borland C Compiler (now embarcadero)
if(C_COMPILER_ID_LOWER MATCHES "embarcadero|borland")
    set(CMAKE_C_COMPILER_IS_BORLAND TRUE)
endif()

# Tasking
if(C_COMPILER_ID_LOWER MATCHES "tasking")
    set(CMAKE_C_COMPILER_IS_TASKING TRUE)
endif()

# TODO: MikroC
# TODO: Paradigm ( EOL )
# TODO: Rowley
# TODO: WizC
# TODO: Softune
# TODO: CodeWarrior
# TODO: Renesas SuperH C compiler

###############################################################################
# Export kernel core files as an interface target
###############################################################################
add_library( freertos_kernel_core INTERFACE )

set(FREERTOS_KERNEL_CORE_SRC_FILES
    event_groups.c
    list.c
    queue.c
    stream_buffer.c
    tasks.c
    timers.c )

set(FREERTOS_KERNEL_CORE_HDR_FILES
    FreeRTOS.h
    StackMacros.h
    atomic.h
    deprecated_definitions.h
    event_groups.h
    list.h
    message_buffer.h
    mpu_prototypes.h
    mpu_wrappers.h
    portable.h
    projdefs.h
    queue.h
    semphr.h
    stack_macros.h
    stream_buffer.h
    task.h
    timers.h )

target_sources(
    freertos_kernel_core
    INTERFACE
        ${FREERTOS_KERNEL_CORE_SRC_FILES} )

set(KERNEL_CORE_HEADERS)

if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
    set( FREERTOS_KERNEL_CORE_HDR_PATHS "" )
    foreach(source ${FREERTOS_KERNEL_CORE_HDR_FILES})
        string(PREPEND source "include/")
        list(APPEND FREERTOS_KERNEL_CORE_HDR_PATHS ${source})
    endforeach()
    target_sources(
        freertos_kernel_core
        INTERFACE
    ${FREERTOS_KERNEL_CORE_HDR_PATHS} )

    target_include_directories(
        freertos_kernel_core
        INTERFACE
            include )
else()
    target_sources(
        freertos_kernel_core
        INTERFACE
            FILE_SET HEADERS
                BASE_DIRS include
                FILES ${FREERTOS_KERNEL_CORE_HDR_FILES} )
endif()

add_library( FreeRTOS::Kernel::Core ALIAS freertos_kernel_core )

##############################################################################
# Backwards compatiblity checking
##############################################################################
if(FREERTOS_PORT)
    if( ( FREERTOS_PORT STREQUAL "A_CUSTOM_PORT" ) AND ( NOT TARGET freertos_kernel_port ) )
        message(FATAL_ERROR " FREERTOS_PORT is set to A_CUSTOM_PORT. "
        "Please specify the custom port target with all necessary files. For example:\n"
        " Assuming a directory of:\n"
        "  FreeRTOSCustomPort/\n"
        "    CMakeLists.txt\n"
        "    port.c\n"
        "    portmacro.h\n"
        " Where FreeRTOSCustomPort/CMakeLists.txt is a modified version of:\n"
        "   add_library(freertos_kernel_port STATIC)\n"
        "   target_sources(freertos_kernel_port\n"
        "     PRIVATE\n"
        "       port.c\n"
        "       portmacro.h)\n"
        "   target_include_directories(freertos_kernel_port\n"
        "     PUBLIC\n"
        "      .)\n"
        "   taget_link_libraries(freertos_kernel_port\n"
        "     PRIVATE\n"
        "       freertos_kernel)")
    endif()

    if( NOT TARGET freertos_config )
        message( WARNING "freertos_config target not specified.\n"
        "FreeRTOSConfig.h will be auto-generated by CMake.\n"
        "See target/config.cmake for more information.")
    endif()

    if(  FREERTOS_HEAP STREQUAL "" )
        message( FATAL_ERROR "FREERTOS_HEAP not specified.\n"
        "Set to a number between 1 and 5 or an absolute path to a custom heap.c")
    endif()
else()
    message( STATUS "Auto-detecting ports to expose as library targets." )
endif()

###############################################################################
# Ports (including MPU wrappers and heap implementations )
###############################################################################
add_subdirectory( portable )

if(NOT FREERTOS_PORT)
    add_subdirectory( target )
endif()

###############################################################################
# Backwards-compatiblity usage
###############################################################################
if(FREERTOS_PORT)
    set( is_numeric_heap "$<BOOL:$<FILTER:${FREERTOS_HEAP},EXCLUDE,^[1-5]$>>" )
    set( heap_source "$<IF:${is_numeric_heap},${FREERTOS_HEAP},portable/MemMang/heap_${FREERTOS_HEAP}.c>")
    add_library( freertos_heap INTERFACE ${heap_source} )

    add_library( freertos_kernel STATIC )

    target_link_libraries( freertos_kernel
        PUBLIC
            freertos_config
            freertos_heap
        PRIVATE
            freertos_kernel_port
            freertos_kernel_core )
endif()
