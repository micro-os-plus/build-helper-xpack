#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2021 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

message(VERBOSE "Processing 'tests/platform-qemu-mps2-an386'...")

# -----------------------------------------------------------------------------

set(xpack_platform_compile_definition "PLATFORM_QEMU_MPS2_AN386")
# set(xpack_create_listing true)

# -----------------------------------------------------------------------------
# Define the platform library.

add_library(platform-qemu-mps2-an386-interface INTERFACE EXCLUDE_FROM_ALL)

# -----------------------------------------------------------------------------

target_include_directories(platform-qemu-mps2-an386-interface INTERFACE
  "include-platform"
)

target_sources(platform-qemu-mps2-an386-interface INTERFACE
  # None.
)

target_compile_definitions(platform-qemu-mps2-an386-interface INTERFACE
  "${xpack_platform_compile_definition}"
)

target_compile_options(platform-qemu-mps2-an386-interface INTERFACE
  # None.
)

target_link_libraries(platform-qemu-mps2-an386-interface INTERFACE
  micro-os-plus::devices-qemu-cortexm
)

if (COMMAND xpack_display_target_lists)
  xpack_display_target_lists(platform-qemu-mps2-an386-interface)
endif()

# -----------------------------------------------------------------------------
# Aliases.

add_library(micro-os-plus::platform ALIAS platform-qemu-mps2-an386-interface)
message(VERBOSE "> micro-os-plus::platform -> platform-qemu-mps2-an386-interface")

# =============================================================================
# Define the tests executables.

if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Windows")
  set(extension ".cmd")
endif()

function(add_test_executable name)

  add_executable(${name})

  set_target_properties(${name}

    PROPERTIES
      OUTPUT_NAME "${name}"
  )

  # Include folders.
  # `tests/platform-qemu-mps2-an386/include` was added globally.
  target_include_directories(${name} PRIVATE
      "../include"
  )

  message(VERBOSE "A+ -I tests/include")

  # Application sources.
  target_sources(${name} PRIVATE
      "../src/${name}.cpp"
  )

  message(VERBOSE "A+ tests/src/${name}.cpp")

  target_compile_definitions(${name} PRIVATE
    # None
  )

  # Bare-metal platforms should be warnings free.
  # Native builds may use different toolchain versions, which
  # may trigger unexpected warnings.
  target_compile_options(${name} PRIVATE
      -Werror
  )

  target_link_options(${name} PRIVATE
    -Wl,-Map,platform-bin/${name}-map.txt
    # -v
  )

  target_link_libraries(${name}  PRIVATE
    # Tested library.
    micro-os-plus::xxx-yyy

    # Portable dependencies.
    micro-os-plus::diag-trace

    # Platform specific dependencies.
    micro-os-plus::platform # bring device & architecture too.

    micro-os-plus::libs-c
    micro-os-plus::libs-cpp
    micro-os-plus::semihosting
    micro-os-plus::startup
  )

  # TODO use add_custom_target()
  # https://cmake.org/cmake/help/v3.20/command/add_custom_command.html
  add_custom_command(TARGET ${name} POST_BUILD
    COMMAND ${CMAKE_SIZE} --format=berkeley "$<TARGET_FILE:${name}>"
  )

  if(xpack_create_listing)
    add_custom_command(TARGET ${name} POST_BUILD
      COMMAND ${CMAKE_OBJDUMP} --source --all-headers --demangle --line-numbers --wide "$<TARGET_FILE:${name}>" > ${name}-list.txt
      VERBATIM
    )
  endif()

  message(VERBOSE "A> ${name}")

endfunction()

# -----------------------------------------------------------------------------

add_test_executable(sample-test)

add_test(
  NAME "sample-test"

  COMMAND qemu-system-arm${extension}
    --machine mps2-an386
    --cpu cortex-m4
    --kernel sample-test.elf
    --nographic
    -d unimp,guest_errors
    --semihosting-config enable=on,target=native
    --semihosting-config arg=sample-test
)

# -----------------------------------------------------------------------------

add_test_executable(unit-test)

target_link_libraries(unit-test  PRIVATE
  micro-os-plus::micro-test-plus
)

add_test(
  NAME "unit-test"

  COMMAND qemu-system-arm${extension}
    --machine mps2-an386
    --cpu cortex-m4
    --kernel unit-test.elf
    --nographic
    -d unimp,guest_errors
    --semihosting-config enable=on,target=native
    --semihosting-config arg=unit-test
)

# -----------------------------------------------------------------------------

