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

message (VERBOSE
         "Including 'tests/platforms/${PLATFORM_NAME}/cmake/artefacts.cmake'..."
)

# -----------------------------------------------------------------------------

# NOTE: Exceptions are disabled.

# -----------------------------------------------------------------------------

set (XPACK_QEMU_BINARY "qemu-system-aarch64")
set (XPACK_QEMU_MACHINE_ARGS --machine virt --cpu cortex-a72)
set (XPACK_QEMU_EXTRA_ARGS -smp 1 --nographic -d unimp,guest_errors)

# The libraries are compiled before the platform library, so they need to get
# the same compile options.
{%- if testsConfig.useObjectsLibrary %}
prepend_compile_common_private_options (
  {{ packageScope }}-{{ packageName }}-objects-library
)
{%- elsif testsConfig.useStaticLibrary %}
prepend_compile_common_private_options (
  {{ packageScope }}-{{ packageName }}-static-library
)
{% endif %}

# -----------------------------------------------------------------------------

if (XPACK_ENABLE_SAMPLE_TEST)
  add_cross_test_executable (sample-test)
  target_link_cross_tests_libraries (sample-test tests::sample)

  xpack_display_target_lists (sample-test)
  message (VERBOSE "A> sample-test")

  add_qemu_test (NAME "sample-test" COMMAND sample-test one two)

  message (VERBOSE "") # Separator for readability
endif ()

# -----------------------------------------------------------------------------

if (XPACK_ENABLE_UNIT_TEST)
  add_cross_test_executable (unit-test)
  target_link_cross_tests_libraries (unit-test tests::unit)

  xpack_display_target_lists (unit-test)
  message (VERBOSE "A> unit-test")

  add_qemu_test (
    NAME "unit-test" COMMAND unit-test one two)

  message (VERBOSE "") # Separator for readability
endif ()

# -----------------------------------------------------------------------------
