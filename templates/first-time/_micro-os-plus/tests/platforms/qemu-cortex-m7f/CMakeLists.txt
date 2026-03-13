# -----------------------------------------------------------------------------
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

# Create the platform specific test executables.

# -----------------------------------------------------------------------------

message(VERBOSE "Processing 'tests/platforms/qemu-cortex-m7f'...")

include("cmake/platform-library.cmake")

# -----------------------------------------------------------------------------

# set(xpack_create_listing true) set(xpack_create_hex true)

# -----------------------------------------------------------------------------

if(ENABLE_MINIMAL_TEST)
  add_cross_test_executable(minimal-test)

  target_link_libraries(
    minimal-test
    PRIVATE # The compile & link options common to all platforms.
            micro-os-plus::common-options
            # Library with the current test.
            test::minimal
            # Tested library.
            micro-os-plus::micro-test-plus
            # Portable dependencies.
            micro-os-plus::diag-trace
            # Platform specific dependencies.
            micro-os-plus::platform # bring device & architecture too
            micro-os-plus::semihosting)

  message(VERBOSE "A> minimal-test")

  add_test(
    NAME "minimal-test"
    COMMAND
      qemu-system-arm${extension} --machine mps2-an500 --cpu cortex-m7 --kernel
      minimal-test.elf --nographic -d unimp,guest_errors --semihosting-config
      enable=on,target=native,arg=minimal-test,arg=one,arg=two)
endif()

# -----------------------------------------------------------------------------

if(ENABLE_SAMPLE_TEST)
  add_cross_test_executable(sample-test)

  target_link_libraries(
    sample-test
    PRIVATE # The compile & link options common to all platforms.
            micro-os-plus::common-options
            # Library with the current test.
            test::sample
            # Tested library.
            micro-os-plus::micro-test-plus
            # Portable dependencies.
            micro-os-plus::diag-trace
            # Platform specific dependencies.
            micro-os-plus::platform # bring device & architecture too
            micro-os-plus::semihosting)

  message(VERBOSE "A> sample-test")

  add_test(
    NAME "sample-test"
    COMMAND
      qemu-system-arm${extension} --machine mps2-an500 --cpu cortex-m7 --kernel
      sample-test.elf --nographic -d unimp,guest_errors --semihosting-config
      enable=on,target=native,arg=sample-test,arg=one,arg=two)
endif()

# -----------------------------------------------------------------------------

if(ENABLE_UNIT_TEST)
  add_cross_test_executable(unit-test)

  target_link_libraries(
    unit-test
    PRIVATE # The compile & link options common to all platforms.
            micro-os-plus::common-options
            # Library with the current test.
            test::unit
            # Tested library.
            micro-os-plus::micro-test-plus
            # Portable dependencies.
            micro-os-plus::diag-trace
            # Platform specific dependencies.
            micro-os-plus::platform # bring device & architecture too
            micro-os-plus::semihosting)

  message(VERBOSE "A> unit-test")

  add_test(
    NAME "unit-test"
    COMMAND
      qemu-system-arm${extension} --machine mps2-an500 --cpu cortex-m7 --kernel
      unit-test.elf --nographic -d unimp,guest_errors --semihosting-config
      enable=on,target=native,arg=unit-test
    # --semihosting-config arg=--verbose
  )
endif()

# -----------------------------------------------------------------------------
