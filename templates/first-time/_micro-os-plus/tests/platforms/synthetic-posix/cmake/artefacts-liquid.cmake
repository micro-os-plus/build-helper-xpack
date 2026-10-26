# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ project (https://{{ packageScope }}.github.io/).
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

if (CMAKE_BUILD_TYPE STREQUAL "Debug" AND CMAKE_CXX_COMPILER_ID STREQUAL
                                          "AppleClang"
)
  # Enable it temporarily to check the coverage on macOS.
  set (XPACK_ENABLE_COVERAGE false)
endif ()

# The libraries are compiled before the platform library, so they need to get
# the same compile options.
{%- if testsConfig.useObjectsLibrary %}
prepend_compile_common_private_options (
  {{ packageScope }}-{{ packageName }}-objects-library
)

if (XPACK_ENABLE_COVERAGE)
  add_compile_coverage_private_options (
    {{ packageScope }}-{{ packageName }}-objects-library
  )
endif ()
{%- elsif testsConfig.useStaticLibrary %}
prepend_compile_common_private_options (
  {{ packageScope }}-{{ packageName }}-static-library
)

if (XPACK_ENABLE_COVERAGE)
  add_compile_coverage_private_options (
    {{ packageScope }}-{{ packageName }}-static-library
  )
endif ()
{% endif %}

# -----------------------------------------------------------------------------

if (XPACK_ENABLE_SAMPLE_TEST)
  add_native_test_executable (sample-test)
  target_link_native_test_libraries (sample-test tests::sample)

  xpack_display_target_lists (sample-test)
  message (VERBOSE "A> sample-test")

  add_test (NAME "sample-test" COMMAND sample-test one two)
  message (VERBOSE "T> sample-test")

  message (VERBOSE "") # Separator for readability
endif ()

# -----------------------------------------------------------------------------

if (XPACK_ENABLE_UNIT_TEST)
  add_native_test_executable (unit-test)
  target_link_native_test_libraries (unit-test tests::unit)

  if (XPACK_ENABLE_COVERAGE)
    add_compile_coverage_private_options (unit-test)
    add_link_coverage_private_options (unit-test)
  endif ()

  xpack_display_target_lists (unit-test)
  message (VERBOSE "A> unit-test")

  add_test (NAME "unit-test" COMMAND unit-test one two)
  message (VERBOSE "T> unit-test")

  if (XPACK_ENABLE_COVERAGE)
    set_tests_properties (
      "unit-test" PROPERTIES ENVIRONMENT "LLVM_PROFILE_FILE=unit-test.profraw"
    )

    add_test (
      NAME "unit-test-coverage"
      COMMAND bash "${CMAKE_CURRENT_SOURCE_DIR}/../../scripts/show-coverage.sh"
              unit-test unit-test
    )
    set_tests_properties ("unit-test-coverage" PROPERTIES DEPENDS "unit-test")
    message (VERBOSE "T> unit-test-coverage")
  endif ()

  message (VERBOSE "") # Separator for readability
endif ()

# -----------------------------------------------------------------------------
