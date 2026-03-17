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

# -----------------------------------------------------------------------------

# Bare-metal executables have the .elf extension.
if (CMAKE_SYSTEM_NAME STREQUAL "Generic")
  set (CMAKE_EXECUTABLE_SUFFIX ".elf")
endif ()

# -----------------------------------------------------------------------------
# Non-target specific definitions.

# The globals must be included in this scope, before creating any targets. The
# compile options, symbols and include folders apply to all compiled sources,
# from all libraries.
if ("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Windows")
  set (extension ".cmd")
endif ()

# Define functions like add_cross_test_executable().
include ("cmake/common-functions.cmake")

# Define `micro-os-plus::common-options` with the compile & link options common
# to all platforms.
include ("cmake/common-options-library.cmake")

# Platform specific definitions.
include ("platforms/${PLATFORM_NAME}/cmake/definitions.cmake")

# Set `xpack_dependencies_folders` with the platform specific dependencies.
include ("platforms/${PLATFORM_NAME}/cmake/dependencies-folders.cmake")

# Iterate the platform dependencies and `add_subdirectory()`.
xpack_add_dependencies_subdirectories (
  "${xpack_dependencies_folders}" "xpacks-bin"
)

# -----------------------------------------------------------------------------

# Add the project library, defined one level above.
message (VERBOSE "Adding top library...")
add_subdirectory (".." "top-bin")

# -----------------------------------------------------------------------------
# Platform specifics.

# Add the platform specific targets and tests. For consistency, the binaries are
# created in the `platform-bin` folder.
add_subdirectory ("platforms/${PLATFORM_NAME}" "platform-bin")

# -----------------------------------------------------------------------------
