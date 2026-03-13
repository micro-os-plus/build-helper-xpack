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

message(VERBOSE "Processing 'tests/platforms/qemu-riscv-rv32imac'...")

include("cmake/platform-library.cmake")

# -----------------------------------------------------------------------------

# set(xpack_create_listing true) set(xpack_create_hex true)

# -----------------------------------------------------------------------------

if(ENABLE_MINIMAL_TEST)
  add_cross_test_executable(minimal-test)
  target_link_cross_test_libraries(minimal-test test::minimal)

  message(VERBOSE "A> minimal-test")

  add_test(
    NAME "minimal-test"
    COMMAND
      qemu-system-riscv32${extension} --machine virt --cpu rv32 --kernel
      minimal-test.elf -smp 1 -bios none --nographic -d unimp,guest_errors
      --semihosting-config
      enable=on,target=native,arg=minimal-test,arg=one,arg=two)
endif()

# -----------------------------------------------------------------------------

if(ENABLE_SAMPLE_TEST)
  add_cross_test_executable(sample-test)
  target_link_cross_test_libraries(sample-test test::sample)

  message(VERBOSE "A> sample-test")

  add_test(
    NAME "sample-test"
    COMMAND
      qemu-system-riscv32${extension} --machine virt --cpu rv32 --kernel
      sample-test.elf -smp 1 -bios none --nographic -d unimp,guest_errors
      --semihosting-config
      enable=on,target=native,arg=sample-test,arg=one,arg=two)
endif()

# -----------------------------------------------------------------------------

if(ENABLE_UNIT_TEST)
  add_cross_test_executable(unit-test)
  target_link_cross_test_libraries(unit-test test::unit)

  message(VERBOSE "A> unit-test")

  add_test(
    NAME "unit-test"
    COMMAND
      qemu-system-riscv32${extension} --machine virt --cpu rv32 --kernel
      unit-test.elf --nographic -smp 1 -bios none -d unimp,guest_errors
      --semihosting-config enable=on,target=native,arg=unit-test)
endif()

# -----------------------------------------------------------------------------
