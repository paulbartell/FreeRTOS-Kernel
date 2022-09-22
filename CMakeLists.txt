cmake_minimum_required(VERSION 3.15)

set(PROJECT_ROOT ${CMAKE_SOURCE_DIR})
set(KCONFIG_ROOT ${CMAKE_SOURCE_DIR}/Kconfig)
set(AUTOCONF_H ${CMAKE_CURRENT_BINARY_DIR}/generated/FreeRTOSConfig.h)
set(DOTCONFIG .config)

set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS ${AUTOCONF_H})
set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS ${DOTCONFIG})

file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/generated)

# 2.2 Misc
#
# import_kconfig(<prefix> <kconfig_fragment> [<keys>])
#
# Parse a KConfig fragment (typically with extension .config) and
# introduce all the symbols that are prefixed with 'prefix' into the
# CMake namespace. List all created variable names in the 'keys'
# output variable if present.
function(import_kconfig prefix kconfig_fragment)
  # Parse the lines prefixed with 'prefix' in ${kconfig_fragment}
  file(
    STRINGS
    ${kconfig_fragment}
    DOT_CONFIG_LIST
    REGEX "^${prefix}"
    ENCODING "UTF-8"
  )

  foreach (CONFIG ${DOT_CONFIG_LIST})
    # CONFIG could look like: CONFIG_NET_BUF=y

    # Match the first part, the variable name
    string(REGEX MATCH "[^=]+" CONF_VARIABLE_NAME ${CONFIG})

    # Match the second part, variable value
    string(REGEX MATCH "=(.+$)" CONF_VARIABLE_VALUE ${CONFIG})

    # The variable name match we just did included the '=' symbol. To just get the
    # part on the RHS we use match group 1
    set(CONF_VARIABLE_VALUE ${CMAKE_MATCH_1})

    if("${CONF_VARIABLE_VALUE}" MATCHES "^\"(.*)\"$") # Is surrounded by quotes
      set(CONF_VARIABLE_VALUE ${CMAKE_MATCH_1})
    endif()

    set("${CONF_VARIABLE_NAME}" "${CONF_VARIABLE_VALUE}" PARENT_SCOPE)
    list(APPEND keys "${CONF_VARIABLE_NAME}")

    # message( "Config:" ${CONF_VARIABLE_NAME} ":" ${CONF_VARIABLE_VALUE} )

  endforeach()

  foreach(outvar ${ARGN})
    set(${outvar} "${keys}" PARENT_SCOPE)
  endforeach()
endfunction()

import_kconfig(CONFIG ${DOTCONFIG})

include(toolchain/toolchain.cmake)

project(kconfig-example C)

find_package( Python3 COMPONENTS Interpreter Development REQUIRED)
if(NOT Python3_FOUND)
    message(FATAL_ERROR "Failed to find a python3 interpreter.")
endif()

find_program(VIRTUALENV virtualenv)
if(NOT VIRTUALENV)
    message(FATAL_ERROR "Failed to find `virtualenv` in PATH. Please install the python virtualenv module.")
endif()

add_custom_command(
    OUTPUT venv
    COMMAND ${VIRTUALENV} venv
)
add_custom_command(
    OUTPUT venv.stamp
    DEPENDS venv ${CMAKE_CURRENT_SOURCE_DIR}/tools/requirements.txt
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/tools/requirements.txt requirements.txt
    COMMAND ./venv/bin/pip install -r requirements.txt --upgrade
)

add_custom_command(
    OUTPUT ${AUTOCONF_H}
    DEPENDS ${CMAKE_SOURCE_DIR}/${DOTCONFIG} venv.stamp
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/venv/bin/python3 ${CMAKE_SOURCE_DIR}/tools/genconfig.py -i ${CMAKE_SOURCE_DIR}/${DOTCONFIG} -o ${AUTOCONF_H}
)

add_custom_target(freertos_config_file ALL DEPENDS ${AUTOCONF_H})

add_library(freertos_config INTERFACE)
target_include_directories(freertos_config INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/generated)

include(portable/ports.cmake)

add_subdirectory(portable)

target_link_libraries(freertos_kernel_port INTERFACE freertos_config)

add_library(freertos_kernel STATIC
    croutine.c
    event_groups.c
    list.c
    queue.c
    stream_buffer.c
    tasks.c
    timers.c
    portable/MemMang/heap_4.c
)

target_link_libraries(freertos_kernel PUBLIC freertos_config)

target_include_directories(freertos_kernel
    PUBLIC
        ${CMAKE_SOURCE_DIR}/include
)

target_link_libraries(freertos_kernel PRIVATE freertos_kernel_port)