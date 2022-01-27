#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2022 Liviu Ionescu
#
# This Source Code Form is subject to the terms of the MIT License.
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# Use targets as include markers (variables are not scope independent).
if(TARGET micro-os-plus-xxx-yyy-zzz-included)
  return()
else()
  add_custom_target(micro-os-plus-xxx-yyy-zzz-included)
endif()

if(NOT TARGET micro-os-plus-build-helper-included)
  message(FATAL_ERROR "Include the mandatory build-helper (xpacks/micro-os-plus-build-helper/cmake/xpack-helper.cmake)")
endif()

message(STATUS "Processing xPack ${PACKAGE_JSON_NAME}@${PACKAGE_JSON_VERSION}...")

# -----------------------------------------------------------------------------
# Dependencies.

find_package(micro-os-plus-aaa-bbb-ccc REQUIRED)

# -----------------------------------------------------------------------------
# The current folder.

get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------

if(NOT TARGET micro-os-plus-xxx-yyy-zzz-static)

  # https://cmake.org/cmake/help/v3.20/command/add_library.html?highlight=interface#normal-libraries

  add_library(micro-os-plus-xxx-yyy-zzz-static STATIC)

  # ---------------------------------------------------------------------------
  # Target settings.

  xpack_glob_recurse_cxx(source_files "${xpack_current_folder}/src")
  xpack_display_relative_paths("${source_files}" "${xpack_current_folder}")

  target_sources(
    micro-os-plus-xxx-yyy-zzz-static

    # PRIVATE sources are added to the SOURCES property of targetName,
    # while INTERFACE sources are added to the INTERFACE_SOURCES property.
    # A PUBLIC source is added to both properties (not useful).
    PRIVATE
      ${source_files}

    # IDEs may like to have the header files here too.
  )

  target_include_directories(
    micro-os-plus-xxx-yyy-zzz-static

    PUBLIC
      ${xpack_current_folder}/include
  )

  target_compile_definitions(
    micro-os-plus-xxx-yyy-zzz-static

    PUBLIC
      # Preprocessor macro definitions
  )

  target_compile_options(
    micro-os-plus-xxx-yyy-zzz-static

    PRIVATE
      # Perhaps ignore some warnings.
  )

  target_link_options(
    micro-os-plus-xxx-yyy-zzz-static

    PRIVATE
      # Linker options
  )

  target_link_libraries(
    micro-os-plus-xxx-yyy-zzz-static

    PRIVATE
      # Dependencies
      micro-os-plus::aaa-bbb-ccc
  )

  # ---------------------------------------------------------------------------
  # Aliases.

  add_library(micro-os-plus::xxx-yyy-zzz ALIAS micro-os-plus-xxx-yyy-zzz-static)
  message(STATUS "=> micro-os-plus::xxx-yyy-zzz (micro-os-plus-xxx-yyy-zzz-static)")

endif()

# -----------------------------------------------------------------------------
