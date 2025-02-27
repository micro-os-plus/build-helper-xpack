# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ distribution.
# (https://github.com/micro-os-plus/)
# Copyright (c) 2022 Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# Define a list of folders where the platform dependencies are located.

# -----------------------------------------------------------------------------

# Required in devices-qemu-riscv.
set(xpack_device_compile_definition "MICRO_OS_PLUS_DEVICE_QEMU_RISCV_RV32IMAC")

set(xpack_platform_compile_definition "MICRO_OS_PLUS_PLATFORM_QEMU_RISCV_RV32IMAC")

# -----------------------------------------------------------------------------
set(xpack_dependencies_folders

  # The BINARY_DIR is the `build/<config>` folder.
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/architecture-riscv"
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/devices-qemu-riscv"
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/semihosting"
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/startup"

  # The SOURCE_DIR is the `tests` folder.
  "${CMAKE_SOURCE_DIR}/xpacks/@micro-os-plus/diag-trace"
  "${CMAKE_SOURCE_DIR}/xpacks/@micro-os-plus/micro-test-plus"
)

# -----------------------------------------------------------------------------
