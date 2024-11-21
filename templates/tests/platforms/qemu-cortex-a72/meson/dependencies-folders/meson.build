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

# Required in devices-qemu-aarch64.
xpack_device_compile_definition='MICRO_OS_PLUS_DEVICE_QEMU_CORTEX_A72'

xpack_platform_compile_definition = 'MICRO_OS_PLUS_PLATFORM_QEMU_CORTEX_A72'

# -----------------------------------------------------------------------------

# The base folder is tests. The order is significative.
xpack_dependencies_folders = [

  'xpacks/@micro-os-plus/diag-trace', # -
  'xpacks/@micro-os-plus/micro-test-plus', # -
  # -
  # 'xpacks/@micro-os-plus/version',

  # -
  # xpack_build_folder_relative_path + '/xpacks/@xpack-3rd-party/arm-cmsis-core',
  # (architecture) -
  xpack_build_folder_relative_path + '/xpacks/@micro-os-plus/architecture-aarch64',

  # +(diag_trace, architecture) >semihosting
  xpack_build_folder_relative_path + '/xpacks/@micro-os-plus/semihosting',

  # -
  xpack_build_folder_relative_path + '/xpacks/@micro-os-plus/startup',

  # +(arm_cmsis_core_m, devices_cortexa, startup) >devices_qemu_aarch64
  xpack_build_folder_relative_path + '/xpacks/@micro-os-plus/devices-qemu-aarch64',

  'platforms/qemu-cortex-a72/meson/platform-options',
]

# -----------------------------------------------------------------------------
