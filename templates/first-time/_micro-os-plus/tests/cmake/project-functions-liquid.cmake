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

function (target_link_native_test_libraries name library_name)
  target_link_libraries (
    ${name}
    PRIVATE # The compile & link options common to all platforms.
            micro-os-plus::common-options
            # Library with the current test.
            ${library_name}
            # Tested library.
            micro-os-plus::{{packageName}}
            # Portable dependencies.
            micro-os-plus::diag-trace
            # Platform specific dependencies and common compile/link options.
            micro-os-plus::platform
  )
endfunction ()

# -----------------------------------------------------------------------------

function (target_link_cross_test_libraries name library_name)
  target_link_libraries (
    ${name}
    PRIVATE # The compile & link options common to all platforms.
            micro-os-plus::common-options
            # Library with the current test.
            ${library_name}
            # Tested library.
            micro-os-plus::{{packageName}}
            # Portable dependencies.
            micro-os-plus::diag-trace
            # Platform specific dependencies.
            micro-os-plus::platform # bring device & architecture too
            micro-os-plus::semihosting
  )
endfunction ()

# -----------------------------------------------------------------------------
