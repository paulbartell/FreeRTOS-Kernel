###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# Set variable if not already defined in current scope
###############################################################################
macro(set_default cfg_key cfg_value )
    if(NOT DEFINED ${cfg_key})
        set(${cfg_key} ${cfg_value})
    endif()
endmacro()

###############################################################################
# Set kernel configuration defaults in current scope
###############################################################################
macro(config_set_defaults)
    set_default( configMINIMAL_STACK_SIZE 2048 )
    set_default( configMAX_PRIORITIES 32 )
    set_default( configUSE_PREEMPTION ON )
    set_default( configUSE_IDLE_HOOK OFF )
    set_default( configUSE_TICK_HOOK OFF )
    set_default( configUSE_16_BIT_TICKS OFF )
    set_default( configCPU_CLOCK_HZ 1000000 )
    set_default( configTICK_RATE_HZ 1000 )
    set_default( configTOTAL_HEAP_SIZE 8192 )
    set_default( configUSE_TRACE_FACILITY OFF )
    set_default( configUSE_DAEMON_TASK_STARTUP_HOOK OFF )
    set_default( configUSE_APPLICATION_TASK_TAG OFF )
    set_default( configNUM_THREAD_LOCAL_STORAGE_POINTERS 1 )
    set_default( configUSE_RECURSIVE_MUTEXES ON )
    set_default( configUSE_MUTEXES ON )
    set_default( configUSE_TIMERS ON )
    set_default( configUSE_COUNTING_SEMAPHORES ON )
    set_default( configMAX_TASK_NAME_LEN 16 )
    set_default( configIDLE_SHOULD_YIELD OFF )
    set_default( configTIMER_TASK_PRIORITY 1 )
    set_default( configTIMER_QUEUE_LENGTH 8 )
    set_default( configTIMER_TASK_STACK_DEPTH 256 )
    set_default( configQUEUE_REGISTRY_SIZE 0 )
    set_default( configCHECK_FOR_STACK_OVERFLOW ON )
    set_default( configRECORD_STACK_HIGH_ADDRESS ON )
    set_default( configINCLUDE_FREERTOS_TASK_C_ADDITIONS_H OFF )
    set_default( configGENERATE_RUN_TIME_STATS OFF )
    set_default( configUSE_MALLOC_FAILED_HOOK OFF )
    set_default( configEXPECTED_IDLE_TIME_BEFORE_SLEEP 0 )
    set_default( configUSE_TICKLESS_IDLE OFF )
    set_default( configUSE_QUEUE_SETS ON )
    set_default( configUSE_TIME_SLICING ON )
    set_default( configINCLUDE_APPLICATION_DEFINED_PRIVILEGED_FUNCTIONS OFF )
    set_default( configUSE_STATS_FORMATTING_FUNCTIONS OFF )
    set_default( configUSE_TRACE_FACILITY OFF )
    set_default( configUSE_PORT_OPTIMISED_TASK_SELECTION OFF )
    set_default( configAPPLICATION_ALLOCATED_HEAP OFF )
    set_default( configUSE_TASK_NOTIFICATIONS ON )
    set_default( configTASK_NOTIFICATION_ARRAY_ENTRIES 2 )
    set_default( configUSE_POSIX_ERRNO ON )
    set_default( configSUPPORT_STATIC_ALLOCATION OFF )
    set_default( configSUPPORT_DYNAMIC_ALLOCATION ON )
    set_default( configSTACK_DEPTH_TYPE size_t )
    set_default( configRUN_TIME_COUNTER_TYPE size_t )
    set_default( configMESSAGE_BUFFER_LENGTH_TYPE size_t )
    set_default( configINITIAL_TICK_COUNT 0 )
    set_default( configUSE_TASK_FPU_SUPPORT 2 )
    set_default( configENABLE_MPU ON )
    set_default( configENABLE_FPU ON )
    set_default( configENABLE_MVE ON )
    set_default( configENABLE_TRUSTZONE ON )
    set_default( configRUN_FREERTOS_SECURE_ONLY OFF )
    set_default( configMAX_SYSCALL_INTERRUPT_PRIORITY 32 )
    set_default( configKERNEL_INTERRUPT_PRIORITY 255 )
    set_default( configENFORCE_SYSTEM_CALLS_FROM_KERNEL_ONLY ON )
    set_default( configALLOW_UNPRIVILEGED_CRITICAL_SECTIONS OFF )
endmacro()

###############################################################################
# Add a FreeRTOSConfig.h file for the target
###############################################################################
function(target_add_freertos_config target_name)
    config_set_defaults()
    configure_file( ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/FreeRTOSConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/FreeRTOSConfig.h )

    if( ${CMAKE_VERSION} VERSION_LESS "3.23.0" )
        target_sources( ${target_name} PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/FreeRTOSConfig.h )
        target_include_directories( ${target_name} PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/${target_name} )
    else()
        target_sources( ${target_name}
            PUBLIC
                FILE_SET HEADERS
                    BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}/${target_name}
                    FILES ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/FreeRTOSConfig.h )
    endif()

endfunction()