###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

if(DEFINED TOOLCHAIN_PATH)
    set(TC_BIN_PATH ${TOOLCHAIN_PATH}/bin/)
else()
    set(TC_BIN_PATH "")
endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

if(${CONFIG_TOOLCHAIN_PREFIX})
    set(TC_PREFIX ${CONFIG_TOOLCHAIN_PREFIX})
else()
    set(TC_PREFIX avr-)
endif()

set(CMAKE_SYSTEM_PROCESSOR avr)
set(CMAKE_SYSTEM_NAME Generic)

set(ARM_GCC_FLAGS "")

set(CMAKE_C_FLAGS "-nostdlib --specs=nosys.specs -fdata-sections -ffunction-sections -Wl,--gc-sections" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS "-nostdlib ${CMAKE_C_FLAGS} -fno-exceptions" CACHE INTERNAL "")

include(${CMAKE_CURRENT_LIST_DIR}/gcc-common.cmake)
