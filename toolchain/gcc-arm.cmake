###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

# Determine Toolchain binary path
if(DEFINED TOOLCHAIN_PATH)
    set(TC_BIN_PATH ${TOOLCHAIN_PATH}/bin/)
else()
    set(TC_BIN_PATH "")
endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# set(CMAKE_C_COMPILER_ID gcc)

if(${CONFIG_TOOLCHAIN_PREFIX})
    set(TC_PREFIX ${CONFIG_TOOLCHAIN_PREFIX})
else()
    set(TC_PREFIX arm-none-eabi-)
endif()

add_compile_options(-nostdlib --specs=nosys.specs -fdata-sections -ffunction-sections -Wl,--gc-sections)
add_link_options(-nostdlib -fno-exceptions)

include(${CMAKE_CURRENT_LIST_DIR}/gcc-common.cmake)

gcc_get_allowed_options("mfpu" gcc_arm_allowed_mfpu_options)
gcc_get_allowed_options("march" gcc_arm_allowed_march_options)
gcc_get_allowed_options("mcpu" gcc_arm_allowed_mcpu_options)
