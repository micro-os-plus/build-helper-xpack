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

# This file includes various helper functions that may be used in 
# in CMake scripts.
# All functions are prefixed with `xpack_`, used as a namespace.

# -----------------------------------------------------------------------------

message(STATUS "Including xpack-helper...")

# -----------------------------------------------------------------------------

# Add the `meta` and `cmake` folders to CMAKE_PREFIX_PATH.
# If an `xpacks` folder exists, iterate its children.

function(xpack_append_cmake_prefix_path path)

  set(prefix_path ${CMAKE_PREFIX_PATH})

  file(GLOB children LIST_DIRECTORIES true "${path}/*")
  foreach(child ${children})
  if(IS_DIRECTORY "${child}")
      file(GLOB files "${child}/meta/*-config.cmake")
      if(files)
        list(APPEND prefix_path "${child}/meta")
      endif()
    endif()
  endforeach()

  set(CMAKE_PREFIX_PATH "${prefix_path}" PARENT_SCOPE)

endfunction()

# -----------------------------------------------------------------------------

# Extract the three semver numbers from the input string.
# The second argument is a string with the variable name in the parent scope.
# Assume the string contains a full semver (https://semver.org).

function (xpack_parse_semver version_in variable_name)

  # Ignore the possible pre-release part.
  string(REGEX REPLACE "^\([0-9]+\.[0-9]+\.[0-9]+\).*$" "\\1" semver "${version_in}")

  # Pass the three numbers semver to the caller.
  set("${variable_name}" "${semver}" PARENT_SCOPE)

  string(REGEX REPLACE "^\([0-9]+\)\.\([0-9]+\)\.\([0-9]+\)$" "\\1" semver_major "${semver}")
  string(REGEX REPLACE "^\([0-9]+\)\.\([0-9]+\)\.\([0-9]+\)$" "\\2" semver_minor "${semver}")
  string(REGEX REPLACE "^\([0-9]+\)\.\([0-9]+\)\.\([0-9]+\)$" "\\3" semver_patch "${semver}")

  # Pass the separate semver components to the caller.
  set("${variable_name}_MAJOR" "${semver_major}" PARENT_SCOPE)
  set("${variable_name}_MINOR" "${semver_minor}" PARENT_SCOPE)
  set("${variable_name}_PATCH" "${semver_patch}" PARENT_SCOPE)

endfunction()

macro (xpack_parse_package_json_semver package_json_path)

  # Read the whole file into memory.
  file(READ "${package_json_path}" package_json_content)

  string(JSON package_json_name GET "${package_json_content}" "name")
  message(STATUS "package.name: ${package_json_name}")

  # Parse JSON and get the version property.
  string(JSON package_json_version_in GET "${package_json_content}" "version")
  message(STATUS "package.version: ${package_json_version_in}")

  xpack_parse_semver("${package_json_version_in}" "PACKAGE_JSON_VERSION")

endmacro()

# -----------------------------------------------------------------------------
