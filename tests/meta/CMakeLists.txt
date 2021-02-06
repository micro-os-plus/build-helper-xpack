#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2021 Liviu Ionescu
#
# This Source Code Form is subject to the terms of the MIT License.
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# https://cmake.org/cmake/help/v3.18/
cmake_minimum_required(VERSION 3.18)
message(STATUS "CMake version: ${CMAKE_VERSION}")

# -----------------------------------------------------------------------------

get_filename_component(xpack_tests_root_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
get_filename_component(xpack_root_folder ${xpack_tests_root_folder} DIRECTORY)

include("${xpack_root_folder}/cmake/xpack-helper.cmake")

# append_cmake_prefix_path("${xpack_tests_root_folder}")
append_cmake_prefix_path("${xpack_root_folder}")

# Leave the result in PACKAGE_JSON_VERSION[*]
parse_package_json_semver("${xpack_root_folder}/package.json")

# -----------------------------------------------------------------------------

project(
  xpack-test
  DESCRIPTION "build-helper-xpack tests"
  VERSION "${PACKAGE_JSON_VERSION}"
)

# -----------------------------------------------------------------------------

# Display an empty line, to better see the configuration output.
message(STATUS "")

# -----------------------------------------------------------------------------
