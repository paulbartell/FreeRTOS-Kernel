###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

set(TC_SUFFIX                           ${CMAKE_EXECUTABLE_SUFFIX})

set(CMAKE_C_COMPILER_WORKS              TRUE)
set(CMAKE_CXX_COMPILER_WORKS            TRUE)

# Toolchain Utilities
set(CMAKE_AR                            ${TC_BIN_PATH}llvm-ar${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER                  ${TC_BIN_PATH}clang${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_C_COMPILER                    ${TC_BIN_PATH}clang${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER                  ${TC_BIN_PATH}clang++${TC_SUFFIX} CACHE INTERNAL "" )
set(CMAKE_LINKER                        ${TC_BIN_PATH}llvm-link${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_OBJCOPY                       ${TC_BIN_PATH}llvm-objcopy${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_RANLIB                        ${TC_BIN_PATH}llvm-ranlib${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_SIZE                          ${TC_BIN_PATH}llvm-size${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_STRIP                         ${TC_BIN_PATH}llvm-strip${TC_SUFFIX} CACHE INTERNAL "")

set(CMAKE_C_FLAGS_DEBUG                 "-Os -g" CACHE INTERNAL "")
set(CMAKE_C_FLAGS_RELEASE               "-Os -DNDEBUG" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_DEBUG               "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_RELEASE             "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")
