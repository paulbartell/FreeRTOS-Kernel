# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT

###############################################################################
# ARMv8-M TF-M
###############################################################################
add_library( freertos_port_armv8m_tfm
             INTERFACE
             os_wrapper_freertos.c )

###############################################################################
# Cortex-M23 TFM
###############################################################################
add_library( freertos_port_armv8m_cm23_tfm INTERFACE )

target_link_libraries( freertos_port_armv8m_cm23_tfm
                       INTERFACE
                       freertos_port_armv8m_tfm
                       freertos_port_armv8m_cm23_ntz )

add_library( FreeRTOS::Kernel::Port::GCC_ARM_CM23_TFM ALIAS freertos_port_armv8m_cm23_tfm )

###############################################################################
# Cortex-M33 TFM
###############################################################################
add_library( freertos_port_armv8m_cm33_tfm INTERFACE )

target_link_libraries( freertos_port_armv8m_cm33_tfm
                       INTERFACE
                       freertos_port_armv8m_tfm
                       freertos_port_armv8m_cm33_ntz )

add_library( FreeRTOS::Kernel::Port::GCC_ARM_CM33_TFM ALIAS freertos_port_armv8m_cm33_tfm )

###############################################################################
# Cortex-M55 TFM
###############################################################################
add_library( freertos_port_armv8m_cm55_tfm INTERFACE )

target_link_libraries( freertos_port_armv8m_cm55_tfm
                       INTERFACE
                       freertos_port_armv8m_tfm
                       freertos_port_armv8m_cm55_ntz )

add_library( FreeRTOS::Kernel::Port::GCC_ARM_CM55_TFM ALIAS freertos_port_armv8m_cm55_tfm )

###############################################################################
# Cortex-M85 TFM
###############################################################################
add_library( freertos_port_armv8m_cm85_tfm INTERFACE )

target_link_libraries( freertos_port_armv8m_cm85_tfm
                       INTERFACE
                       freertos_port_armv8m_tfm
                       freertos_port_armv8m_cm85_ntz )

add_library( FreeRTOS::Kernel::Port::GCC_ARM_CM85_TFM ALIAS freertos_port_armv8m_cm85_tfm )
