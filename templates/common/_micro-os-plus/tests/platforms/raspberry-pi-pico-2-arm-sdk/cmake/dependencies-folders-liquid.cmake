# -----------------------------------------------------------------------------
# DO NOT EDIT! Automatically generated from template file:
# {{fromFilePath}}
#
# This file is part of the µOS++ project (https://micro-os-plus.github.io/).
# Copyright (c) 2022-{{currentYear}} Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can be
# obtained from https://opensource.org/licenses/mit.
#
# -----------------------------------------------------------------------------

# Define a list of folders where the platform dependencies are located.

# -----------------------------------------------------------------------------

message (
  VERBOSE
  "Including tests/platforms/${PLATFORM_NAME}/cmake/dependencies-folders.cmake..."
)

# -----------------------------------------------------------------------------

# All the dependencies folders will be included in `tests-main.cmake` with
# `add_subdirectory()`.

# The SOURCE_DIR is the `tests` folder; the BINARY_DIR is the `build/<config>`
# folder.

set (
  xpack_dependencies_folders
  #
  # Portable dependencies.
  "${CMAKE_SOURCE_DIR}/xpacks/@micro-os-plus/diag-trace"
  #
  # Platform specific dependencies.
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/architecture-cortexm"
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/devices-raspberry-pi"
  # Pico SDK.
  "${CMAKE_BINARY_DIR}/xpacks/@xpack-3rd-party/raspberrypi-pico-sdk"
  #
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/semihosting"
  "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/startup"
)

# -----------------------------------------------------------------------------

# The top level project sets CMAKE_C_EXTENSIONS OFF for portability, but the
# Raspberry Pi Pico SDK C sources (e.g. runtime_init.c) use the GNU `asm`
# keyword, which is not available in strict ISO C mode (-std=c11); GCC only
# recognises it with GNU extensions enabled (-std=gnu11). Re-enable C extensions
# here, for this platform only, since this variable is inherited by the
# `add_subdirectory()` calls used to bring in the dependencies below.
set (CMAKE_C_EXTENSIONS ON)

set (PICO_BOARD pico2)
set (PICO_PLATFORM rp2350-arm-s)
set (PICO_CXX_ENABLE_EXCEPTIONS 1)
# Avoid fetching/building picotool from source; disables UF2 output and the
# post-build hash/signing step on the RP2350 image.
set (PICO_NO_PICOTOOL 1)

# -----------------------------------------------------------------------------
