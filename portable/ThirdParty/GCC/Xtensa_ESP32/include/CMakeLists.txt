###############################################################################
# FreeRTOS Kernel
# Copyright (C) 2022 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
# SPDX-License-Identifier: MIT
###############################################################################

freertos_define_port( NAME freertos_port_xtensa_esp32_include
                      ALIAS XTENSA_ESP32_INCLUDE
                      COMMON_FILES
                      HEADERS
                        xt_asm_utils.h
                        xtensa_config.h
                        port_systick.h
                        portbenchmark.h
                        FreeRTOSConfig_arch.h
                        xtensa_timer.h
                        xtensa_api.h
                        xtensa_rtos.h
                        xtensa_context.h
                        portmacro.h )
