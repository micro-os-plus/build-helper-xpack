#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2022 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# This file is intended to be consumed by applications with:
#
# `add_subdirectory("xpacks/xpack-3rd-party-xxx-yyy")`
#
# The result is an interface library that can be added to the linker with:
#
# `target_link_libraries(your-target PRIVATE xpack-3rd-party::xxx-yyy)`

# -----------------------------------------------------------------------------
## Preamble ##

# https://cmake.org/cmake/help/v3.20/
cmake_minimum_required(VERSION 3.20)

project(xpack-3rd-party-xxx-yyy
  DESCRIPTION "XXX YYY"
)

if(COMMAND xpack_get_package_name_and_version)
  xpack_get_package_name_and_version("${CMAKE_CURRENT_SOURCE_DIR}/package.json")
  message(VERBOSE "Processing xPack ${PACKAGE_JSON_NAME}@${PACKAGE_JSON_VERSION}...")
endif()

# -----------------------------------------------------------------------------
## The project library definitions ##

add_library(xpack-3rd-party-xxx-yyy-interface INTERFACE EXCLUDE_FROM_ALL)

# -----------------------------------------------------------------------------
# Target settings.

target_include_directories(xpack-3rd-party-xxx-yyy-interface INTERFACE
  "include"
)

target_sources(xpack-3rd-party-xxx-yyy-interface INTERFACE
  "src/yyy.cpp"
)

target_compile_definitions(xpack-3rd-party-xxx-yyy-interface INTERFACE
  # None.
)

target_compile_options(xpack-3rd-party-xxx-yyy-interface INTERFACE

  # -Wno-padded

  # parameter passing for argument of type '...' changed in GCC 7.1
  # -Wno-psabi

  # $<$<C_COMPILER_ID:GNU>:-Wno-conversion>
  # $<$<C_COMPILER_ID:GNU>:-Wno-aggregate-return>

  # $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-c++98-c++11-c++14-c++17-compat-pedantic>
  # $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-c++98-c++11-compat>
  # $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-c++98-compat>
  # $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-c++98-compat-pedantic>
  # $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-c99-extensions>
  # $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-pedantic>
  # $<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-extra-semi-stmt>

  # $<$<COMPILE_LANGUAGE:CXX>:-Wno-ctor-dtor-privacy>

  # $<$<AND:$<COMPILE_LANGUAGE:CXX>,$<C_COMPILER_ID:GNU>>:-Wno-useless-cast>

)

target_link_libraries(xpack-3rd-party-xxx-yyy-interface INTERFACE
  # None.
)

if (COMMAND xpack_display_target_lists)
  xpack_display_target_lists(xpack-3rd-party-xxx-yyy-interface)
endif()

# -----------------------------------------------------------------------------
# Aliases.

# https://cmake.org/cmake/help/v3.20/command/add_library.html#alias-libraries
add_library(xpack-3rd-party::xxx-yyy ALIAS xpack-3rd-party-xxx-yyy-interface)
message(VERBOSE "> xpack-3rd-party::xxx-yyy -> xpack-3rd-party-xxx-yyy-interface")

# -----------------------------------------------------------------------------
