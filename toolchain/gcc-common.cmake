###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

# Determine Toolchain binary path
if(DEFINED TOOLCHAIN_PATH)
    set(TC_BIN_PATH                     ${TOOLCHAIN_PATH}/bin/)
else()
    set(TC_BIN_PATH                     "")
endif()

set(TC_SUFFIX                           ${CMAKE_EXECUTABLE_SUFFIX})

set(CMAKE_C_COMPILER_WORKS              TRUE)
set(CMAKE_CXX_COMPILER_WORKS            TRUE)

# Toolchain Utilities
set(CMAKE_AR                            ${TC_BIN_PATH}${TC_PREFIX}ar${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER                  ${TC_BIN_PATH}${TC_PREFIX}gcc${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_C_COMPILER                    ${TC_BIN_PATH}${TC_PREFIX}gcc${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER                  ${TC_BIN_PATH}${TC_PREFIX}g++${TC_SUFFIX} CACHE INTERNAL "" )
set(CMAKE_LINKER                        ${TC_BIN_PATH}${TC_PREFIX}ld${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_OBJCOPY                       ${TC_BIN_PATH}${TC_PREFIX}objcopy${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_RANLIB                        ${TC_BIN_PATH}${TC_PREFIX}ranlib${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_SIZE                          ${TC_BIN_PATH}${TC_PREFIX}size${TC_SUFFIX} CACHE INTERNAL "")
set(CMAKE_STRIP                         ${TC_BIN_PATH}${TC_PREFIX}size${TC_SUFFIX} CACHE INTERNAL "")

set(CMAKE_C_FLAGS_DEBUG                 "-Os -g" CACHE INTERNAL "")
set(CMAKE_C_FLAGS_RELEASE               "-Os -DNDEBUG" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_DEBUG               "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_RELEASE             "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")


# when giving a bogus option to a GCC switch, GCC outputs the following:
# gcc: error: unrecognized '-${switch_to_test}' target: foo
# gcc: note: valid arguments are: value1 value2 value3
# this function extracts those values into allowed_options as a sorted list
function( gcc_get_allowed_options switch_to_test allowed_options )
    file( TOUCH ${CMAKE_SOURCE_DIR}/foo.c )
    execute_process( COMMAND ${CMAKE_C_COMPILER} -${switch_to_test}=foo foo.c
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE compiler_output
        ERROR_VARIABLE compiler_output )
    file( REMOVE ${CMAKE_SOURCE_DIR}/foo.c )

    # strip trailing newline
    string( REGEX REPLACE "\n$" "" compiler_output ${compiler_output} )
    # create a list out of the output lines
    string( REPLACE "\n" ";" compiler_output ${compiler_output} )
    list( LENGTH compiler_output line_count )

    if( line_count GREATER 1 )
        list( GET compiler_output 1 compiler_output )
    else()
        # if the switch doesn't exist, then there are no valid options
        message( AUTHOR_WARNING "${CMAKE_C_COMPILER}: Unknown switch -${switch_to_test}" )
        return()
    endif()

    list( LENGTH compiler_output output_length )

    if( output_length GREATER 0 )
        # remove human-readable message
        string( REGEX REPLACE "^.*are: " "" compiler_output ${compiler_output} )
        # create final list
        string( REPLACE " " ";" compiler_output ${compiler_output} )
        list( SORT compiler_output )
        set( ${allowed_options} ${compiler_output} PARENT_SCOPE )
    endif()
endfunction()

function( gcc_is_flag_allowed allowed_options switch_to_test is_allowed )
    string(REPLACE "=" ";" switch_to_test ${switch_to_test} )
    list(GET switch_to_test 1 switch_to_test)
    list(FIND allowed_options ${switch_to_test} index)

    if(index EQUAL -1)
        message(AUTHOR_WARNING "${switch_to_test} not supported by ${CMAKE_C_COMPILER} ${CMAKE_C_COMPILER_VERSION}")
        set( ${is_allowed} 0 PARENT_SCOPE )
    else()
        set( ${is_allowed} 1 PARENT_SCOPE )
    endif()
endfunction()
