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

if(NOT CLANG_M_CPU)
    if(${CONFIG_ARM_CORE_CORTEX_MO})
        set(CLANG_M_CPU cortex-m0)
    elseif(${CONFIG_ARM_CORE_CORTEX_MO_PLUS})
        set(CLANG_M_CPU cortex-m0plus)
    elseif(${CONFIG_ARM_CORE_CORTEX_M3})
        set(CLANG_M_CPU cortex-m3)
    elseif(${CONFIG_ARM_CORE_CORTEX_M4})
        set(CLANG_M_CPU cortex-m4)
    elseif(${CONFIG_ARM_CORE_CORTEX_M33})
        set(CLANG_M_CPU cortex-m33)
    elseif(${CONFIG_ARM_CORE_CORTEX_R4})
        set(CLANG_M_CPU cortex-r4)
    elseif(${CONFIG_ARM_CORE_CORTEX_R5})
        set(CLANG_M_CPU cortex-r5)
    endif()
endif()

if(NOT CLANG_M_FPU)
    if(${CONFIG_TARGET_NO_FPU})
        set(CLANG_M_FPU "")
    elseif(${CONFIG_TARGET_ARM_FPU_VFPV3_D16})
        set(CLANG_M_FPU vfpv3-d16)
    elseif(${CONFIG_TARGET_ARM_FPU_FPV4_SP_D16})
        set(CLANG_M_FPU fpv4-sp-d16)
    elseif(${CONFIG_TARGET_ARM_FPU_FPV5_SP_D16})
        set(CLANG_M_FPU fpv5-sp-d16)
    endif()
endif()

set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_NAME Generic)

set(TI_ARM_CLANG_FLAGS "")

if(CLANG_M_CPU)
    set(TI_ARM_CLANG_FLAGS "${TI_ARM_CLANG_FLAGS} -mcpu=${CLANG_M_CPU}")
endif()

if(CLANG_M_FPU)
    set(TI_ARM_CLANG_FLAGS "${TI_ARM_CLANG_FLAGS} -mfpu=${CLANG_M_FPU}")
    set(TI_ARM_CLANG_FLAGS "${TI_ARM_CLANG_FLAGS} -target=arm-ti-none-eabihf -mfloat-abi=hard")
else()
    set(TI_ARM_CLANG_FLAGS "${TI_ARM_CLANG_FLAGS} -target=arm-ti-none-eabi -mfloat-abi=soft")
endif()

# TODO: DSP Extension, other extensions
set(CMAKE_C_FLAGS "-nostdlib --specs=nosys.specs ${TI_ARM_CLANG_FLAGS} -fdata-sections -ffunction-sections -Wl,--gc-sections" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS "-nostdlib ${APP_CXX_FLAGS} ${CMAKE_C_FLAGS} -fno-exceptions" CACHE INTERNAL "")

set(TC_SUFFIX                           ${CMAKE_EXECUTABLE_SUFFIX})

set(CMAKE_C_COMPILER_WORKS              TRUE)
set(CMAKE_CXX_COMPILER_WORKS            TRUE)

# Toolchain Utilities
set(CMAKE_AR                            ${TC_BIN_PATH}/tiarmar${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER                  ${TC_BIN_PATH}/tiarmclang${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_C_COMPILER                    ${TC_BIN_PATH}/tiarmclang${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER                  ${TC_BIN_PATH}/tiarmclang${TC_SUFFIX} CACHE INTERNAL "" )
set(CMAKE_LINKER                        ${TC_BIN_PATH}/tiarmlnk${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_OBJCOPY                       ${TC_BIN_PATH}/tiarmobjcopy${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_SIZE                          ${TC_BIN_PATH}/tiarmsize${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_STRIP                         ${TC_BIN_PATH}/tiarmstrip${TC_SUFFIX} CACHE INTERNAL "")

set(CMAKE_C_FLAGS_DEBUG                 "-Os -g" CACHE INTERNAL "")
set(CMAKE_C_FLAGS_RELEASE               "-Os -DNDEBUG" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_DEBUG               "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_RELEASE             "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")
