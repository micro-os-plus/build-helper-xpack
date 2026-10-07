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

# -----------------------------------------------------------------------------
# Dependencies.

message (VERBOSE "")
# Set `xpack_dependencies_folders` with the platform specific dependencies.
include ("platforms/${PLATFORM_NAME}/cmake/dependencies-folders.cmake")

{% if packageScopedName == '@micro-os-plus/diag-trace' -%}
# Add the project library, defined one level above.
message (VERBOSE "")
message (VERBOSE "Adding top library...")
message (VERBOSE "")
add_subdirectory (".." "top-bin")

{% endif -%}

foreach (folder ${xpack_dependencies_folders})
  file (RELATIVE_PATH relative_folder "${CMAKE_SOURCE_DIR}" "${folder}")
  message (VERBOSE "  ${relative_folder}")
endforeach ()

message (VERBOSE "")
# Set `xpack_dependencies_libraries` with the platform specific libraries.
include ("platforms/${PLATFORM_NAME}/cmake/dependencies-libraries.cmake")
foreach (library ${xpack_dependencies_libraries})
  message (VERBOSE "  ${library}")
endforeach ()

# Iterate the platform dependencies and `add_subdirectory()`.
message (VERBOSE "")
message (VERBOSE "Adding dependencies libraries...")
xpack_add_dependencies_subdirectories (
  "${xpack_dependencies_folders}" "dependencies-bin"
)

# -----------------------------------------------------------------------------

# Add the platform library. The artefacts are created in the
# `platform-bin` folder.
message (VERBOSE "")
message (VERBOSE "Adding platform library...")
message (VERBOSE "")
add_subdirectory ("platforms/${PLATFORM_NAME}" "platform-bin")

{% if packageScopedName != '@micro-os-plus/diag-trace' -%}
# -----------------------------------------------------------------------------

# Add the project library, defined one level above.
message (VERBOSE "")
message (VERBOSE "Adding top library...")
message (VERBOSE "")
add_subdirectory (".." "top-bin")

{% endif -%}

# -----------------------------------------------------------------------------

# Iterate the folders from `project-definitions.cmake` and `add_subdirectory()`.
message (VERBOSE "")
message (VERBOSE "Adding tests libraries...")
xpack_add_dependencies_subdirectories (
  "${xpack_dependencies_tests_folders}" "tests-bin"
)

# -----------------------------------------------------------------------------

# With all libraries processed, include the artefacts and tests definitions.
message (VERBOSE "")
message (VERBOSE "Adding tests artefacts...")
message (VERBOSE "")
include ("platforms/${PLATFORM_NAME}/cmake/artefacts.cmake")

# -----------------------------------------------------------------------------

message (VERBOSE "")

# -----------------------------------------------------------------------------
