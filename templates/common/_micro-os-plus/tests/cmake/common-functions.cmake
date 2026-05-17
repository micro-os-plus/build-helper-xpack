# -----------------------------------------------------------------------------
# DO NOT EDIT! Automatically generated from build-helper/templates.
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

# This file defines common functions used by the platforms.

# -----------------------------------------------------------------------------

message (VERBOSE "Including tests/cmake/common-functions.cmake...")

# -----------------------------------------------------------------------------

if (NOT CMAKE_SIZE)
  set (CMAKE_SIZE "size")
endif ()

if (NOT CMAKE_OBJDUMP)
  set (CMAKE_OBJDUMP "objdump")
endif ()

# -----------------------------------------------------------------------------

function (add_native_test_executable name)
  add_executable (${name})

  set_target_properties (${name} PROPERTIES OUTPUT_NAME "${name}")

  # https://cmake.org/cmake/help/v3.20/manual/cmake-generator-expressions.7.html
  # The link options were defined in `platform-native-interface`.
  target_link_options (
    ${name} PRIVATE
    $<$<PLATFORM_ID:Linux,Windows>:-Wl,-Map,platform-bin/${name}-map.txt> # -v
  )

  # TODO use add_custom_target()
  # https://cmake.org/cmake/help/v3.20/command/add_custom_command.html
  if (XPACK_ENABLE_REPORT_SIZE)
    add_custom_command (
      TARGET ${name}
      POST_BUILD
      COMMAND ${CMAKE_SIZE} "$<TARGET_FILE:${name}>"
    )
  endif ()

  if (XPACK_ENABLE_CREATE_LISTING)
    add_custom_command (
      TARGET ${name}
      POST_BUILD
      # --all-headers -> Invalid/Unsupported object file format
      COMMAND ${CMAKE_OBJDUMP} --source --demangle --line-numbers --wide
              "$<TARGET_FILE:${name}>" > ${name}-list.txt
      VERBATIM
    )
  endif ()
endfunction ()

# -----------------------------------------------------------------------------

function (add_cross_test_executable name)
  add_executable (${name})

  set_target_properties (${name} PROPERTIES OUTPUT_NAME "${name}")

  target_link_options (
    ${name} PRIVATE -Wl,-Map,platform-bin/${name}-map.txt # -v
  )

  # TODO use add_custom_target()
  # https://cmake.org/cmake/help/v3.20/command/add_custom_command.html
  if (XPACK_ENABLE_REPORT_SIZE)
    add_custom_command (
      TARGET ${name}
      POST_BUILD
      COMMAND ${CMAKE_SIZE} --format=berkeley "$<TARGET_FILE:${name}>"
    )
  endif ()

  if (XPACK_ENABLE_CREATE_HEX)
    add_custom_command (
      TARGET ${name}
      POST_BUILD
      COMMAND ${CMAKE_OBJCOPY} -O ihex "$<TARGET_FILE:${name}>"
              "$<TARGET_FILE:${name}>.hex"
    )
  endif ()

  if (XPACK_ENABLE_CREATE_LISTING)
    add_custom_command (
      TARGET ${name}
      POST_BUILD
      COMMAND ${CMAKE_OBJDUMP} --source --all-headers --demangle --line-numbers
              --wide "$<TARGET_FILE:${name}>" > ${name}-list.txt
      VERBATIM
    )
  endif ()
endfunction ()

# -----------------------------------------------------------------------------

function (add_compile_coverage_private_options target)
  target_compile_options (
    ${target}
    PRIVATE $<$<CXX_COMPILER_ID:Clang,AppleClang>:-fprofile-instr-generate
            -fcoverage-mapping -fcoverage-mcdc>
  )
endfunction ()

function (add_link_coverage_private_options target)
  target_link_options (
    ${target} PRIVATE
    $<$<CXX_COMPILER_ID:Clang,AppleClang>:-fprofile-instr-generate>
  )
endfunction ()

# -----------------------------------------------------------------------------

function (add_compile_common_private_options target)
  target_include_directories (
    ${target}
    PRIVATE
      $<TARGET_PROPERTY:micro-os-plus::common-options,INTERFACE_INCLUDE_DIRECTORIES>
      $<TARGET_PROPERTY:micro-os-plus::platform,INTERFACE_INCLUDE_DIRECTORIES>
  )
  target_compile_definitions (
    ${target}
    PRIVATE
      $<TARGET_PROPERTY:micro-os-plus::common-options,INTERFACE_COMPILE_DEFINITIONS>
      $<TARGET_PROPERTY:micro-os-plus::platform,INTERFACE_COMPILE_DEFINITIONS>
  )
  target_compile_options (
    ${target}
    PRIVATE
      $<TARGET_PROPERTY:micro-os-plus::common-options,INTERFACE_COMPILE_OPTIONS>
      $<TARGET_PROPERTY:micro-os-plus::platform,INTERFACE_COMPILE_OPTIONS>
  )
endfunction ()

# -----------------------------------------------------------------------------
