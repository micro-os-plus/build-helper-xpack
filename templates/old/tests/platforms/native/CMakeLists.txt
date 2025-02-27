# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ distribution.
# (https://github.com/micro-os-plus/)
# Copyright (c) 2022 Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# Create the platform specific test executables.

message(VERBOSE "Processing 'tests/platform-native'...")

# -----------------------------------------------------------------------------
function(add_test_executable name)
  add_executable(${name})

  # Include folders.
  # `platform-native/include` was added globally.
  target_include_directories(${name} PRIVATE
    "../../include"
  )

  message(VERBOSE "A+ -I tests/include")

  set_target_properties(${name} PROPERTIES OUTPUT_NAME "${name}")

  # Application sources.
  target_sources(${name} PRIVATE
    "../../src/${name}.cpp"
  )

  message(VERBOSE "A+ tests/src/${name}.cpp")

  target_compile_definitions(${name} PRIVATE

    # None.
  )

  # The compile options were defined globally.
  target_compile_options(${name} PRIVATE

    # None.
  )

  # https://cmake.org/cmake/help/v3.20/manual/cmake-generator-expressions.7.html
  # The link options were defined in `platform-native-interface`.
  target_link_options(${name} PRIVATE
    $<$<PLATFORM_ID:Linux,Windows>:-Wl,-Map,platform-bin/${name}-map.txt>

    # -v
  )

  target_link_libraries(${name} PRIVATE

    # Tested library.
    micro-os-plus::xxx-yyy

    # Portable dependencies.
    micro-os-plus::diag-trace

    # Platform specific dependencies and common compile/link options.
    micro-os-plus::platform
  )

  if(xpack_create_listing)
    add_custom_command(TARGET ${name} POST_BUILD

      # --all-headers -> Invalid/Unsupported object file format
      COMMAND ${CMAKE_OBJDUMP} --source --demangle --line-numbers --wide "$<TARGET_FILE:${name}>" > ${name}-list.txt
      VERBATIM
    )
  endif()

  message(VERBOSE "A> ${name}")
endfunction()

# -----------------------------------------------------------------------------
if(ENABLE_SAMPLE_TEST)
  add_test_executable(sample-test)

  add_test(
    NAME "sample-test"
    COMMAND sample-test one two
  )
endif()

# -----------------------------------------------------------------------------
if(ENABLE_UNIT_TEST)
  add_test_executable(unit-test)

  target_link_libraries(unit-test PRIVATE
    micro-os-plus::micro-test-plus
  )

  add_test(
    NAME "unit-test"
    COMMAND unit-test # --verbose
  )

  # add_custom_command(
  # TARGET "unit-test" POST_BUILD
  # COMMAND ${CMAKE_OBJDUMP} -x "$<TARGET_FILE:unit-test>"
  # VERBATIM
  # )
endif()

# -----------------------------------------------------------------------------
