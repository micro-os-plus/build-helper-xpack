# -----------------------------------------------------------------------------
# DO NOT EDIT! Automatically generated from build-helper/templates.
#
# This file is part of the µOS++ project (https://micro-os-plus.github.io/).
# Copyright (c) 2022-2026 Liviu Ionescu. All rights reserved.
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

message(
  VERBOSE
  "Including tests/platforms/${PLATFORM_NAME}/cmake/dependencies-folders.cmake..."
)

# -----------------------------------------------------------------------------

set(xpack_dependencies_folders
    # Project dependencies.
    ${xpack_dependencies_project_folders}
    # The BINARY_DIR is the `build/<config>` folder.
    # "${CMAKE_BINARY_DIR}/xpacks/@xpack-3rd-party/arm-cmsis-core"
    "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/architecture-aarch32"
    "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/devices-qemu-aarch32"
    "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/semihosting"
    "${CMAKE_BINARY_DIR}/xpacks/@micro-os-plus/startup"
    # The SOURCE_DIR is the `tests` folder.
    {% if packageScopedName == '@micro-os-plus/diag-trace' %}# {% endif %}"${CMAKE_SOURCE_DIR}/xpacks/@micro-os-plus/diag-trace"
    {% if packageScopedName == '@micro-os-plus/micro-test-plus' %}# {% endif %}"${CMAKE_SOURCE_DIR}/xpacks/@micro-os-plus/micro-test-plus"
)

# -----------------------------------------------------------------------------
