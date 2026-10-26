# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ project (https://micro-os-plus.github.io/).
# Copyright (c) 2022-{{currentYear}} Liviu Ionescu. All rights reserved.
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

message('Processing tests/platforms/native...')

# -----------------------------------------------------------------------------

# https://mesonbuild.com/Unit-tests.html#malloc_perturb_
xpack_environment = environment()
xpack_environment.set('MALLOC_PERTURB_', '0')

# -----------------------------------------------------------------------------

# Define the tests commands.

if xpack_enable_sample_test

  # https://mesonbuild.com/Reference-manual_functions.html#test
  test(
    'sample-test',
    sample_test,
    args: [ 'one', 'two' ],
    env: xpack_environment
  )

endif

# -----------------------------------------------------------------------------

if xpack_enable_unit_test

  # https://mesonbuild.com/Reference-manual_functions.html#test
  test(
    'unit-test',
    unit_test,
    args: [ 'one', 'two' ],
    env: xpack_environment
  )

endif

# -----------------------------------------------------------------------------
