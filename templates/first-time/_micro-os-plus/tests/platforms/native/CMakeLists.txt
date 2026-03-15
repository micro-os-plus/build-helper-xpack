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

message (VERBOSE "Processing 'tests/platforms/native'...")

include ("cmake/platform-library.cmake")

# -----------------------------------------------------------------------------

if (XPACK_ENABLE_MINIMAL_TEST)
  add_native_test_executable (minimal-test)
  target_link_native_test_libraries (minimal-test test::minimal)

  message (VERBOSE "A> minimal-test")

  add_test (NAME "minimal-test" COMMAND minimal-test one two)
  add_test (NAME "minimal-test --verbose" COMMAND minimal-test one two
                                                  --verbose
  )
  add_test (NAME "minimal-test --quiet" COMMAND minimal-test one two --quiet)
  add_test (NAME "minimal-test --silent" COMMAND minimal-test one two --silent)
endif ()

# -----------------------------------------------------------------------------

if (XPACK_ENABLE_SAMPLE_TEST)
  add_native_test_executable (sample-test)
  target_link_native_test_libraries (sample-test test::sample)

  message (VERBOSE "A> sample-test")

  add_test (NAME "sample-test" COMMAND sample-test one two)
  add_test (NAME "sample-test --verbose" COMMAND sample-test one two --verbose)
  add_test (NAME "sample-test --quiet" COMMAND sample-test one two --quiet)
  add_test (NAME "sample-test --silent" COMMAND sample-test one two --silent)
endif ()

# -----------------------------------------------------------------------------

if (XPACK_ENABLE_UNIT_TEST)
  add_native_test_executable (unit-test)
  target_link_native_test_libraries (unit-test test::unit)

  message (VERBOSE "A> unit-test")

  add_test (NAME "unit-test" COMMAND unit-test)
  add_test (NAME "unit-test --verbose" COMMAND unit-test --verbose)
  add_test (NAME "unit-test --quiet" COMMAND unit-test --quiet)
  add_test (NAME "unit-test --silent" COMMAND unit-test --silent)
endif ()

# -----------------------------------------------------------------------------
