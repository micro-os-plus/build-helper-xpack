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

# Define a list of compiler options to enable as many warnings as possible.
macro(xpack_set_all_compiler_warnings variable_name)

  set(${variable_name}

    -Wall

    # Common GNU C & C++.
    $<$<CXX_COMPILER_ID:GNU>:-Waggregate-return>
    $<$<CXX_COMPILER_ID:GNU>:-Warith-conversion>
    $<$<CXX_COMPILER_ID:GNU>:-Wcast-align>
    $<$<CXX_COMPILER_ID:GNU>:-Wcast-qual>
    $<$<CXX_COMPILER_ID:GNU>:-Wconversion>
    $<$<CXX_COMPILER_ID:GNU>:-Wdouble-promotion>
    $<$<CXX_COMPILER_ID:GNU>:-Wduplicated-branches>
    $<$<CXX_COMPILER_ID:GNU>:-Wduplicated-cond>
    $<$<CXX_COMPILER_ID:GNU>:-Wextra>
    $<$<CXX_COMPILER_ID:GNU>:-Wfloat-conversion>
    $<$<CXX_COMPILER_ID:GNU>:-Wfloat-equal>
    $<$<CXX_COMPILER_ID:GNU>:-Wformat-nonliteral>
    $<$<CXX_COMPILER_ID:GNU>:-Wformat-overflow=2>
    $<$<CXX_COMPILER_ID:GNU>:-Wformat-security>
    $<$<CXX_COMPILER_ID:GNU>:-Wformat-signedness>
    $<$<CXX_COMPILER_ID:GNU>:-Wformat-truncation=2>
    $<$<CXX_COMPILER_ID:GNU>:-Wformat-y2k>
    $<$<CXX_COMPILER_ID:GNU>:-Wformat=2>
    $<$<CXX_COMPILER_ID:GNU>:-Wlogical-op>
    $<$<CXX_COMPILER_ID:GNU>:-Wmissing-declarations>
    $<$<CXX_COMPILER_ID:GNU>:-Wmissing-include-dirs>
    $<$<CXX_COMPILER_ID:GNU>:-Wnull-dereference>
    $<$<CXX_COMPILER_ID:GNU>:-Wpacked>
    $<$<CXX_COMPILER_ID:GNU>:-Wpadded>
    $<$<CXX_COMPILER_ID:GNU>:-Wpointer-arith>
    $<$<CXX_COMPILER_ID:GNU>:-Wredundant-decls>
    $<$<CXX_COMPILER_ID:GNU>:-Wshadow>
    $<$<CXX_COMPILER_ID:GNU>:-Wshift-overflow=2>
    $<$<CXX_COMPILER_ID:GNU>:-Wsign-conversion>
    $<$<CXX_COMPILER_ID:GNU>:-Wswitch-default>
    $<$<CXX_COMPILER_ID:GNU>:-Wswitch-enum>
    $<$<CXX_COMPILER_ID:GNU>:-Wundef>
    $<$<CXX_COMPILER_ID:GNU>:-Wuninitialized>
    $<$<CXX_COMPILER_ID:GNU>:-Wvla>

    # GNU C only.
    $<$<COMPILE_LANG_AND_ID:C,GNU>:-Wbad-function-cast>
    $<$<COMPILE_LANG_AND_ID:C,GNU>:-Wc++-compat>
    $<$<COMPILE_LANG_AND_ID:C,GNU>:-Wduplicate-decl-specifier>
    $<$<COMPILE_LANG_AND_ID:C,GNU>:-Wmissing-prototypes>
    $<$<COMPILE_LANG_AND_ID:C,GNU>:-Wnested-externs>
    $<$<COMPILE_LANG_AND_ID:C,GNU>:-Wold-style-definition>
    $<$<COMPILE_LANG_AND_ID:C,GNU>:-Wstrict-prototypes>

    # GNU C++ only.

    # inherits the "cxx11" ABI tag that 'std::string'
    # $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wabi-tag>
    
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wcomma-subscript>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wctor-dtor-privacy>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wextra-semi>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wmismatched-tags>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wnoexcept>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wnon-virtual-dtor>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wold-style-cast>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Woverloaded-virtual>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wplacement-new=2>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wredundant-tags>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wregister>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wsign-promo>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wstrict-null-sentinel>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wsuggest-final-methods>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wsuggest-final-types>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wsuggest-override>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wuseless-cast>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wvolatile>
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wzero-as-null-pointer-constant>

    # For clang things are much easier.
    $<$<CXX_COMPILER_ID:Clang,AppleClang>:-Weverything>
  )

endmacro()

# -----------------------------------------------------------------------------

macro(xpack_process_package_version)

  # message(STATUS "PACKAGE_FIND_NAME ${PACKAGE_FIND_NAME}")
  # message(STATUS "PACKAGE_FIND_VERSION_MAJOR ${PACKAGE_FIND_VERSION_MAJOR}")
  # message(STATUS "PACKAGE_FIND_VERSION_MINOR ${PACKAGE_FIND_VERSION_MINOR}")
  # message(STATUS "PACKAGE_FIND_VERSION_PATCH ${PACKAGE_FIND_VERSION_PATCH}")
  # message(STATUS "PACKAGE_FIND_VERSION_TWEAK ${PACKAGE_FIND_VERSION_TWEAK}")
  # message(STATUS "PACKAGE_FIND_VERSION_COUNT ${PACKAGE_FIND_VERSION_COUNT}")

  get_filename_component(xpack_project_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
  # message(STATUS "${xpack_project_folder}")

  file(READ "${xpack_project_folder}/package.json" package_json_content)

  string(JSON json_name GET "${package_json_content}" "name")
  string(JSON json_version GET "${package_json_content}" "version")
  # message(STATUS "package.version: ${json_version}")
  set(PACKAGE_JSON_NAME "${json_name}" PARENT_SCOPE)
  set(PACKAGE_JSON_VERSION "${json_version}" PARENT_SCOPE)

  # Ignore the possible pre-release part.
  string(REGEX REPLACE "^\([0-9]+\.[0-9]+\.[0-9]+\).*$" "\\1" semver "${json_version}")

  string(REGEX REPLACE "^\([0-9]+\)\.\([0-9]+\)\.\([0-9]+\)$" "\\1" semver_major "${semver}")
  string(REGEX REPLACE "^\([0-9]+\)\.\([0-9]+\)\.\([0-9]+\)$" "\\2" semver_minor "${semver}")
  string(REGEX REPLACE "^\([0-9]+\)\.\([0-9]+\)\.\([0-9]+\)$" "\\3" semver_patch "${semver}")

  set(PACKAGE_VERSION "${semver}")

  # Defaults.
  set(PACKAGE_VERSION_UNSUITABLE false)
  set(PACKAGE_VERSION_EXACT false)
  set(PACKAGE_VERSION_COMPATIBLE false)

  if(PACKAGE_FIND_VERSION_COUNT LESS 1)
    # No specific version required, any version should be compatible. 
    set(PACKAGE_VERSION_COMPATIBLE true)
    return()
  endif()

  # There is at least the major, check it.

  if(NOT PACKAGE_FIND_VERSION_MAJOR EQUAL semver_major)
    set(PACKAGE_VERSION_UNSUITABLE true)
    return()
  endif()

  # The major is the same, it is compatible.
  set(PACKAGE_VERSION_COMPATIBLE true)

  if(PACKAGE_FIND_VERSION_COUNT LESS 2)
    # If there are no more digits, it is exact.
    set(PACKAGE_VERSION_EXACT true)
    return()
  endif()

  # A minor is also present, check it.

  if(PACKAGE_FIND_VERSION_MINOR GREATER semver_minor)
    # Require a later version, not suitable.
    set(PACKAGE_VERSION_UNSUITABLE true)
    return()
  endif()

  # The minor is at least the requested one.

  if(PACKAGE_FIND_VERSION_MINOR LESS semver_minor)
    # Require a previous version, not exact, but compatible.
    return()
  endif()

  # The minor is the same.

  if(PACKAGE_FIND_VERSION_COUNT LESS 3)
    # If there are no more digits, it is exact.
    set(PACKAGE_VERSION_EXACT true)
    return()
  endif()

  # The patch is also present, check it.

  if(PACKAGE_FIND_VERSION_PATCH GREATER semver_patch)
    # Require a later version, not suitable.
    set(PACKAGE_VERSION_UNSUITABLE true)
    return()
  endif()

  if(PACKAGE_FIND_VERSION_PATCH LESS semver_PATCH)
    # Require a previous version, not exact, but compatible.
    return()
  endif()

  # The patch is the same.

  set(PACKAGE_VERSION_EXACT false)

endmacro()

# -----------------------------------------------------------------------------

