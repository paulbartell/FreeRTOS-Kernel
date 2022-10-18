# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT

###############################################################################
# ARMv8-M TF-M
###############################################################################
add_library( port_armv8m_tfm
             INTERFACE
             os_wrapper_freertos.c )

###############################################################################
# Cortex-M23 TFM
###############################################################################
add_library( port_armv8m_cm23_tfm INTERFACE )

target_link_libraries( port_armv8m_cm23_tfm
                       INTERFACE
                       port_armv8m_tfm
                       port_armv8m_cm23_ntz )

###############################################################################
# Cortex-M33 TFM
###############################################################################
add_library( port_armv8m_cm33_tfm INTERFACE )

target_link_libraries( port_armv8m_cm33_tfm
                       INTERFACE
                       port_armv8m_tfm
                       port_armv8m_cm33_ntz )

###############################################################################
# Cortex-M55 TFM
###############################################################################
add_library( port_armv8m_cm55_tfm INTERFACE )

target_link_libraries( port_armv8m_cm55_tfm
                       INTERFACE
                       port_armv8m_tfm
                       port_armv8m_cm55_ntz )

###############################################################################
# Cortex-M85 TFM
###############################################################################
add_library( port_armv8m_cm85_tfm INTERFACE )

target_link_libraries( port_armv8m_cm85_tfm
                       INTERFACE
                       port_armv8m_tfm
                       port_armv8m_cm85_ntz )
