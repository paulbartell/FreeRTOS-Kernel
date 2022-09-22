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

if(${CONFIG_TOOLCHAIN_PREFIX})
    set(TC_PREFIX ${CONFIG_TOOLCHAIN_PREFIX})
else()
    set(TC_PREFIX avr-)
endif()

if(${CONFIG_TARGET_ARCH_AVR_AVR5})
    set(GCC_M_MCU avr5)
elseif(${CONFIG_TARGET_ARCH_AVR_AVR51})
    set(GCC_M_MCU avr51)
elseif(${CONFIG_TARGET_ARCH_AVR_XMEGA2})
    set(GCC_M_MCU avrxmega3)
elseif(${CONFIG_TARGET_ARCH_AVR_XMEGA3})
    set(GCC_M_MCU avrxmega3)
elseif(${CONFIG_TARGET_ARCH_AVR_XMEGA4})
    set(GCC_M_MCU avrxmega4)
endif()

set(CMAKE_SYSTEM_PROCESSOR avr)
set(CMAKE_SYSTEM_NAME Generic)

set(ARM_GCC_FLAGS "")

if(GCC_M_MCU)
    set(AVR_GCC_FLAGS "${ARM_GCC_FLAGS} -mmcu=${GCC_M_MCU}")
endif()

set(CMAKE_C_FLAGS "-nostdlib --specs=nosys.specs ${AVR_GCC_FLAGS} -fdata-sections -ffunction-sections -Wl,--gc-sections" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS "-nostdlib ${APP_CXX_FLAGS} ${CMAKE_C_FLAGS} -fno-exceptions" CACHE INTERNAL "")

include(${CMAKE_CURRENT_LIST_DIR}/gcc-common.cmake)
