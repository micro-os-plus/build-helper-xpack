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

function(xpack_parse_semver version_in variable_name)

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

macro(xpack_parse_package_json_semver package_json_path)

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

    # Nope. It complains about #include_next, and #pragma does not disable it,
    # at least on GCC 7.
    # -Wpedantic
  )

  # https://cmake.org/cmake/help/v3.18/variable/CMAKE_LANG_COMPILER_ID.html
  if("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")

    # message(STATUS "GCC ${CMAKE_C_COMPILER_VERSION}")

    if("${CMAKE_C_COMPILER_VERSION}" VERSION_LESS "7.0.0")
      message(FATAL_ERROR "GNU GCC older than 7.x not supported.")
    endif()

    message(STATUS "Adding GCC warnings...")

    if("${CMAKE_C_COMPILER_VERSION}" VERSION_GREATER_EQUAL "7.0.0")

      # message(STATUS "Adding GCC 7 warnings...")

      list(APPEND ${variable_name}

        # ---------------------------------------------------------------------
        # Common GNU C & C++.

        -Waggregate-return
        -Wcast-align
        -Wcast-qual
        -Wconversion
        -Wdouble-promotion
        -Wduplicated-branches
        -Wduplicated-cond
        -Wextra
        -Wfloat-conversion
        -Wfloat-equal
        -Wformat-nonliteral
        -Wformat-overflow=2
        -Wformat-security
        -Wformat-signedness
        -Wformat-truncation=2
        -Wformat-y2k
        -Wformat=2
        -Wlogical-op
        -Wmissing-declarations
        -Wmissing-include-dirs
        -Wnull-dereference
        -Wpacked
        -Wpadded
        -Wpointer-arith
        -Wredundant-decls
        -Wshadow
        -Wshift-overflow=2
        -Wsign-conversion
        -Wswitch-default
        -Wswitch-enum
        -Wundef
        -Wuninitialized
        -Wvla
    
        # ---------------------------------------------------------------------
        # GNU C only.

        $<$<COMPILE_LANGUAGE:C>:-Wbad-function-cast>
        $<$<COMPILE_LANGUAGE:C>:-Wc++-compat>
        $<$<COMPILE_LANGUAGE:C>:-Wduplicate-decl-specifier>
        $<$<COMPILE_LANGUAGE:C>:-Wmissing-prototypes>
        $<$<COMPILE_LANGUAGE:C>:-Wnested-externs>
        $<$<COMPILE_LANGUAGE:C>:-Wold-style-definition>
        $<$<COMPILE_LANGUAGE:C>:-Wstrict-prototypes>

        # ---------------------------------------------------------------------
        # GNU C++ only.

        # inherits the "cxx11" ABI tag that 'std::string'
        # $<$<COMPILE_LANGUAGE:CXX>:-Wabi-tag>
        
        $<$<COMPILE_LANGUAGE:CXX>:-Wctor-dtor-privacy>
        $<$<COMPILE_LANGUAGE:CXX>:-Wnoexcept>
        $<$<COMPILE_LANGUAGE:CXX>:-Wnon-virtual-dtor>
        $<$<COMPILE_LANGUAGE:CXX>:-Wold-style-cast>
        $<$<COMPILE_LANGUAGE:CXX>:-Woverloaded-virtual>
        $<$<COMPILE_LANGUAGE:CXX>:-Wplacement-new=2>
        $<$<COMPILE_LANGUAGE:CXX>:-Wregister>
        $<$<COMPILE_LANGUAGE:CXX>:-Wsign-promo>
        $<$<COMPILE_LANGUAGE:CXX>:-Wstrict-null-sentinel>
        $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-final-methods>
        $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-final-types>
        $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-override>
        $<$<COMPILE_LANGUAGE:CXX>:-Wuseless-cast>
        $<$<COMPILE_LANGUAGE:CXX>:-Wzero-as-null-pointer-constant>
      )

    endif()

    if("${CMAKE_C_COMPILER_VERSION}" VERSION_GREATER_EQUAL "8.0.0")

      # message(STATUS "Adding GCC 8 warnings...")

      list(APPEND ${variable_name}

        $<$<COMPILE_LANGUAGE:CXX>:-Wextra-semi>

      )

    endif()
    
    if("${CMAKE_C_COMPILER_VERSION}" VERSION_GREATER_EQUAL "9.0.0")

      # message(STATUS "Adding GCC 9 warnings...")

      list(APPEND ${variable_name}

        # None so far.
      )

    endif()

    if("${CMAKE_C_COMPILER_VERSION}" VERSION_GREATER_EQUAL "10.0.0")

      # message(STATUS "Adding GCC 10 warnings...")

      list(APPEND ${variable_name}

        # ---------------------------------------------------------------------
        # Common GNU C & C++.

        -Warith-conversion
    
        # ---------------------------------------------------------------------
        # GNU C++ only.

        $<$<COMPILE_LANGUAGE:CXX>:-Wcomma-subscript>
        $<$<COMPILE_LANGUAGE:CXX>:-Wredundant-tags>
        $<$<COMPILE_LANGUAGE:CXX>:-Wvolatile>
      )

      # RISC-V 10.1 fails with `note: replace the class-key with 'struct'`.
      if(NOT "${CMAKE_C_COMPILER_VERSION}" VERSION_EQUAL "10.1.0")

        list(APPEND ${variable_name}

          $<$<COMPILE_LANGUAGE:CXX>:-Wmismatched-tags>
        )

      endif()

    endif()

  elseif("${CMAKE_C_COMPILER_ID}" MATCHES ".*Clang")

    message(STATUS "Adding clang warnings...")

    list(APPEND ${variable_name}

      # For clang things are much easier.
      -Weverything
    )

  endif()

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

function(xpack_glob_recurse_cxx variable_name sources_folder_path)

  set(local_sources)
  file(GLOB_RECURSE local_sublist CONFIGURE_DEPENDS "${sources_folder_path}/*.c*")
  list(APPEND local_sources ${local_sublist})
  file(GLOB_RECURSE local_sublist CONFIGURE_DEPENDS "${sources_folder_path}/*.S")
  list(APPEND local_sources ${local_sublist})

  set(${variable_name} ${local_sources} PARENT_SCOPE)

endfunction()

function(xpack_display_relative_paths files_list relative_to_path)

  foreach(file_path IN LISTS files_list)
    file(RELATIVE_PATH file_relative_path "${relative_to_path}" "${file_path}")
    message(STATUS "+ ${file_relative_path}")
  endforeach()

endfunction()

# -----------------------------------------------------------------------------
