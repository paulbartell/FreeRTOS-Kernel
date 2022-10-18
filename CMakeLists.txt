###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

cmake_minimum_required(VERSION 3.16)

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
    croutine.c
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
    croutine.h
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
    target_sources(
        freertos_kernel_core
        INTERFACE
            ${FREERTOS_KERNEL_CORE_HDR_FILES} )

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

###############################################################################
# FreeRTOS Kernel Configuration (Defaults)
###############################################################################
set( configMINIMAL_STACK_SIZE 2048 )
set( configMAX_PRIORITIES 32 )

option( configUSE_PREEMPTION "" ON )
option( configUSE_IDLE_HOOK "" OFF )
option( configUSE_TICK_HOOK "" OFF )
option( configUSE_16_BIT_TICKS "" OFF )

set( configCPU_CLOCK_HZ 1000000 )
set( configTICK_RATE_HZ 1000 )

set( configTOTAL_HEAP_SIZE 8192 )
option( configUSE_TRACE_FACILITY "" OFF )

option( configUSE_DAEMON_TASK_STARTUP_HOOK "" OFF )

option( configUSE_APPLICATION_TASK_TAG "" OFF )
set( configNUM_THREAD_LOCAL_STORAGE_POINTERS 1 )

option( configUSE_RECURSIVE_MUTEXES "" ON )
option( configUSE_MUTEXES "" ON )
option( configUSE_TIMERS "" ON )
option( configUSE_COUNTING_SEMAPHORES "" ON )

set( configMAX_TASK_NAME_LEN 16 )

option( configIDLE_SHOULD_YIELD "" OFF )
set( configTIMER_TASK_PRIORITY 1 )
set( configTIMER_QUEUE_LENGTH 8 )
set( configTIMER_TASK_STACK_DEPTH 256 )
set( configQUEUE_REGISTRY_SIZE 0 )

option( configCHECK_FOR_STACK_OVERFLOW "" ON )
option( configRECORD_STACK_HIGH_ADDRESS "" ON )
option( configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H "" OFF )
option( configGENERATE_RUN_TIME_STATS "" OFF )

option( configUSE_MALLOC_FAILED_HOOK "" OFF )

set( configEXPECTED_IDLE_TIME_BEFORE_SLEEP 0 )


option( configUSE_TICKLESS_IDLE "" OFF )
option( configUSE_QUEUE_SETS "" ON )
option( configUSE_TIME_SLICING "" ON )
option( configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS "" OFF )
option( configUSE_STATS_FORMATTING_FUNCTIONS "" OFF )
option( configUSE_TRACE_FACILITY "" OFF )
option( configUSE_PORT_OPTIMISED_TASK_SELECTION "" OFF )
option( configAPPLICATION_ALLOCATED_HEAP "" OFF )
option( configUSE_TASK_NOTIFICATIONS "" ON )

set( configTASK_NOTIFICATION_ARRAY_ENTRIES 2 )

option( configUSE_POSIX_ERRNO "" ON )
option( configSUPPORT_STATIC_ALLOCATION "" OFF )
option( configSUPPORT_DYNAMIC_ALLOCATION "" ON )

set( configSTACK_DEPTH_TYPE size_t )
set( configRUN_TIME_COUNTER_TYPE size_t )
set( configMESSAGE_BUFFER_LENGTH_TYPE size_t )
set( configINITIAL_TICK_COUNT 0 )

option( configUSE_TASK_FPU_SUPPORT "" ON )
option( configENABLE_MPU "" ON )
option( configENABLE_FPU "" ON )
option( configENABLE_MVE "" ON )
option( configENABLE_TRUSTZONE "" ON )
option( configRUN_FREERTOS_SECURE_ONLY "" OFF )

set( configMAX_SYSCALL_INTERRUPT_PRIORITY 1 )

###############################################################################
# Ports (including MPU wrappers and heap implementations )
###############################################################################
add_subdirectory( portable )

