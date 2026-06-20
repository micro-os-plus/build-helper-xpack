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

# This file defines project specific functions used by the platforms.

# -----------------------------------------------------------------------------

message (VERBOSE "Including tests/cmake/project-functions.cmake...")

# -----------------------------------------------------------------------------

function (target_link_native_test_libraries name test_library_name)
  target_link_libraries (
    ${name}
    PRIVATE # The compile & link options common to all platforms.
            micro-os-plus::common-options
            # Library with the current test.
            ${test_library_name}
            # TODO: remove it after updating architecture dependencies.
            micro-os-plus::diag-trace
            # Platform dependency.
            micro-os-plus::platform # bring device & architecture too
  )
endfunction ()

# -----------------------------------------------------------------------------

function (target_link_cross_test_libraries name library_name)
  target_link_libraries (
    ${name}
    PRIVATE # The compile & link options common to all platforms.
            micro-os-plus::common-options
            # Library with the current test.
            ${test_library_name}
            # TODO: remove it after updating architecture dependencies.
            micro-os-plus::diag-trace
            # Platform specific dependencies.
            micro-os-plus::platform # bring device & architecture too
            micro-os-plus::semihosting
  )
endfunction ()

# -----------------------------------------------------------------------------
