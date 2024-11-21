# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus/)
# Copyright (c) 2022 Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# Define a list of folders where the platform dependencies are located.

# -----------------------------------------------------------------------------

# Informative.
xpack_device_compile_definition = 'MICRO_OS_PLUS_DEVICE_NATIVE'

xpack_platform_compile_definition = 'MICRO_OS_PLUS_PLATFORM_NATIVE'

# -----------------------------------------------------------------------------

# The base folder is tests. The order is significative.
xpack_dependencies_folders = [

  'xpacks/@micro-os-plus/diag-trace', # -
  'xpacks/@micro-os-plus/micro-test-plus', # -

  # (architecture) -
  xpack_build_folder_relative_path + '/xpacks/@micro-os-plus/architecture-synthetic-posix',

  # (platform) architecture-synthetic-posix
  'platforms/native/meson/platform-options',
]

# -----------------------------------------------------------------------------
