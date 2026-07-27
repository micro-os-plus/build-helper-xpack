# -----------------------------------------------------------------------------
# DO NOT EDIT! Automatically generated from template file:
# {{fromFilePath}}
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
{% for testName in testsConfig.tests %}
set (XPACK_ENABLE_{{ testName | replace: '-', '_' | upcase }}_TEST true)
{%- endfor %}

set (xpack_dependencies_tests_folders)

# Each test has its own library. Add only those enabled.
{%- for testName in testsConfig.tests %}
if (XPACK_ENABLE_{{ testName | replace: '-', '_' | upcase }}_TEST)
  list (APPEND xpack_dependencies_tests_folders
        "${CMAKE_SOURCE_DIR}/sources/{{ testName }}"
  )
endif ()
{% endfor %}
# -----------------------------------------------------------------------------

set (XPACK_ENABLE_REPORT_SIZE true)
set (XPACK_ENABLE_CREATE_HEX false)
set (XPACK_ENABLE_CREATE_LISTING true)

# -----------------------------------------------------------------------------
