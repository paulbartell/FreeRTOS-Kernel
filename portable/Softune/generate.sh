#!/bin/bash
shopt -s nullglob

function make_header() {
    portname=${directory::-1}
    portname_lower=${portname,,}

    touch CMakeLists.txt

    tee -a CMakeLists.txt << EOF
###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

###############################################################################
# $portname
###############################################################################

message( FATAL_ERROR "Give ${portname} an alias and remove this message" )

freertos_define_port(
    NAME freertos_port_$portname_lower
    ALIAS # TODO:
EOF

    tee -a CMakeLists.txt << EOF
    HEADERS
EOF
        for header in *.{h,inc}; do
    tee -a CMakeLists.txt << EOF
        $header
EOF
        done
    tee -a CMakeLists.txt << EOF
    SOURCES
EOF
        for source in *.{s,S,c}*; do
    tee -a CMakeLists.txt << EOF
        $source
EOF
        done

    tee -a CMakeLists.txt << EOF
)
EOF
}

for directory in */; do
    pushd $directory
        make_header
    popd
done
