#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2021 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# Definitions required for compiling all files, thus the use of
# add_global_*() functions.
# Must be added with subdir() before creating any library or executable.

message('Including platform-qemu-mps2-an386 globals...')

# -----------------------------------------------------------------------------

platform_common_options = [
  '-mcpu=cortex-m4',
  '-mthumb',
  '-mfloat-abi=hard',

  # '-flto' # fails with undefined __assert_func, _write, etc.

  '-fno-move-loop-invariants',

  '-DGTEST_HAS_PTHREAD=0',
  '-D_POSIX_C_SOURCE=200809L',
]

platform_common_c_extra_options = [
]

platform_common_cpp_extra_options = [
  '-fno-rtti',
  '-fno-use-cxa-atexit',
  '-fno-threadsafe-statics',
]

if get_option('buildtype').contains('debug')
  platform_common_options += [
    '-fno-omit-frame-pointer'
  ]
endif

add_global_arguments(
  platform_common_options,

  language: [ 'c', 'cpp' ]
)

add_global_arguments(
  platform_common_c_extra_options,

  language: [ 'c' ]
)

add_global_arguments(
  platform_common_cpp_extra_options,

  language: [ 'cpp' ]
)

add_global_link_arguments(
  platform_common_options,

  language: [ 'c', 'cpp' ]
)

add_global_link_arguments(
  platform_common_cpp_extra_options,

  language: [ 'cpp' ]
)

xpack_linker_scripts = [
    # Path are relative to the build folder.
  '-Txpacks/micro-os-plus-devices-qemu-cortexm/linker-scripts/mem.ld',
  '-Txpacks/micro-os-plus-architecture-cortexm/linker-scripts/sections.ld',
]

# The base folder is root, via the `top` link.
xpack_dependencies = [
  'xpacks/micro-os-plus-diag-trace', # -
  'xpacks/micro-os-plus-micro-test-plus', # -

  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-version', # -
  xpack_build_folder_relative_path + '/xpacks/xpack-3rd-party-arm-cmsis-core-m', # -
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-architecture-cortexm', # (architecture) -
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-semihosting', # diag-trace, architecture
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-devices-cortexm', # semihosting
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-startup', # version, diag-trace, architecture
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-libs-c', # diag-trace, startup, architecture
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-libs-cpp', # diag-trace
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-devices-qemu-cortexm', # device, diag-trace | (device) arm-cmsis-core-m, architecture-cortexm-device
]

xpack_device_compile_definition='DEVICE_QEMU_CORTEX_M4'

# -----------------------------------------------------------------------------
