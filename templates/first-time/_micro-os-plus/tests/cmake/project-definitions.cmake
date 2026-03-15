# -----------------------------------------------------------------------------
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
# Project specific definitions.

set (XPACK_ENABLE_MINIMAL_TEST true)
set (XPACK_ENABLE_SAMPLE_TEST true)
set (XPACK_ENABLE_UNIT_TEST true)

set (xpack_dependencies_project_folders)

# Each test has its own library. Add only those enabled.
if (XPACK_ENABLE_MINIMAL_TEST)
  list (APPEND xpack_dependencies_project_folders
        "${CMAKE_SOURCE_DIR}/minimal-test"
  )
endif ()

if (XPACK_ENABLE_SAMPLE_TEST)
  list (APPEND xpack_dependencies_project_folders
        "${CMAKE_SOURCE_DIR}/sample-test"
  )
endif ()

if (XPACK_ENABLE_UNIT_TEST)
  list (APPEND xpack_dependencies_project_folders
        "${CMAKE_SOURCE_DIR}/unit-test"
  )
endif ()

# -----------------------------------------------------------------------------

set (XPACK_ENABLE_REPORT_SIZE true)
set (XPACK_ENABLE_CREATE_HEX false)
set (XPACK_ENABLE_CREATE_LISTING true)

# -----------------------------------------------------------------------------
