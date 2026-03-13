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

# -----------------------------------------------------------------------------
# Project specific definitions.

enable_minimal_test = true
enable_sample_test = true
enable_unit_test = true

xpack_dependencies_project_folders = []
 
# Each test has its own library. Add only those enabled.
if enable_minimal_test
  xpack_dependencies_project_folders += [ 'minimal-test' ]
endif

if enable_sample_test
  xpack_dependencies_project_folders += [ 'sample-test' ]
endif

if enable_unit_test
  xpack_dependencies_project_folders += [ 'unit-test' ]
endif

# -----------------------------------------------------------------------------
