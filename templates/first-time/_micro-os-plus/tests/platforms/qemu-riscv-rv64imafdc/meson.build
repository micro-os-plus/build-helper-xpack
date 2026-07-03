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

message('Processing tests/platforms/qemu-riscv-rv64imafdc...')

# -----------------------------------------------------------------------------

qemu = find_program('qemu-system-riscv64')

# https://mesonbuild.com/Unit-tests.html#malloc_perturb_
xpack_environment = environment()
xpack_environment.set('MALLOC_PERTURB_', '0')

# -----------------------------------------------------------------------------

# Define the tests executables.

if xpack_enable_sample_test

  # https://mesonbuild.com/Reference-manual_functions.html#test
  test(
    'sample-test',
    qemu,
    args: [
      '--machine', 'virt',
      '--cpu', 'rv64',
      '--kernel', sample_test,
      '--nographic',
      '-smp', '1',
      '-bios', 'none',
      '-d', 'unimp,guest_errors',
      '--semihosting-config', 'enable=on,target=native,arg=sample-test,arg=one,arg=two',
    ],
    env: xpack_environment
  )

endif

# -----------------------------------------------------------------------------

if xpack_enable_unit_test

  # https://mesonbuild.com/Reference-manual_functions.html#test
  test(
    'unit-test',
    qemu,
    args: [
      '--machine', 'virt',
      '--cpu', 'rv64',
      '--kernel', unit_test,
      '--nographic',
      '-smp', '1',
      '-bios', 'none',
      '-d', 'unimp,guest_errors',
      '--semihosting-config', 'enable=on,target=native,arg=unit-test,arg=--reporter,arg=human',
    ],
    env: xpack_environment
  )

endif

# -----------------------------------------------------------------------------
