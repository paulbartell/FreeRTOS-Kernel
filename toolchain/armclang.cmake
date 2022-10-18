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

set(TC_SUFFIX                           ${CMAKE_EXECUTABLE_SUFFIX})

set(CMAKE_C_COMPILER_WORKS              TRUE)
set(CMAKE_CXX_COMPILER_WORKS            TRUE)

# Toolchain Utilities
set(CMAKE_AR                            ${TC_BIN_PATH}/armar${TC_SUFFIX}        CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER                  ${TC_BIN_PATH}/armclang${TC_SUFFIX}     CACHE INTERNAL "")
set(CMAKE_C_COMPILER                    ${TC_BIN_PATH}/armclang${TC_SUFFIX}     CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER                  ${TC_BIN_PATH}/armclang${TC_SUFFIX}     CACHE INTERNAL "" )
set(CMAKE_LINKER                        ${TC_BIN_PATH}/armlink${TC_SUFFIX}      CACHE INTERNAL "")

# ARMclang does not provide objcopy/ranlib/size/strip, so use arm-none-eabi instead
set(CMAKE_OBJCOPY                       ${TC_BIN_PATH}/arm-none-eabi-objcopy${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_RANLIB                        ${TC_BIN_PATH}/arm-none-eabi-ranlib${TC_SUFFIX}  CACHE INTERNAL "")
set(CMAKE_SIZE                          ${TC_BIN_PATH}/arm-none-eabi-size${TC_SUFFIX}    CACHE INTERNAL "")
set(CMAKE_STRIP                         ${TC_BIN_PATH}/arm-none-eabi-strip${TC_SUFFIX}   CACHE INTERNAL "")

set(CMAKE_C_FLAGS_DEBUG                 "-Os -g" CACHE INTERNAL "")
set(CMAKE_C_FLAGS_RELEASE               "-Os -DNDEBUG" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_DEBUG               "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_RELEASE             "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")
