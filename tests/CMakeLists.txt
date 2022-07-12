# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus/)
# Copyright (c) 2021 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# https://cmake.org/cmake/help/v3.20/
cmake_minimum_required(VERSION 3.20)
message(STATUS "CMake version: ${CMAKE_VERSION}")

# -----------------------------------------------------------------------------

get_filename_component(xpack_project_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

include("${xpack_project_folder}/cmake/micro-os-plus-build-helper.cmake")

# xpack_append_cmake_prefix_path("${xpack_tests_root_folder}")
# xpack_append_cmake_prefix_path("${xpack_project_folder}")

# Leave the result in PACKAGE_JSON_VERSION & _NAME
xpack_get_package_name_and_version("${xpack_project_folder}/package.json")

# -----------------------------------------------------------------------------

project(
  test
  DESCRIPTION "build-helper-xpack tests"
  VERSION "${PACKAGE_JSON_VERSION}"
)

# Nothing to do, only check if CMake is happy with including the helper.
xpack_display_greetings("${CMAKE_CURRENT_SOURCE_DIR}/../package.json")

# -----------------------------------------------------------------------------

# Display an empty line, to better see the configuration output.
message(STATUS "")

# -----------------------------------------------------------------------------
