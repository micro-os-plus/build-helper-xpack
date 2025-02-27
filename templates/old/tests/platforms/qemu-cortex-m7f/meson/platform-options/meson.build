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

# Create the platform specific library.

# -----------------------------------------------------------------------------

message('Including tests/platforms/' + xpack_platform_name + '/meson.build...')

# -----------------------------------------------------------------------------

assert(is_variable('xpack_platform_compile_definition'), 'Define xpack_platform_compile_definition in platforms/' + xpack_platform_name + '/meson.build')

# -----------------------------------------------------------------------------

_local_compile_args = [] # Common C/C++ args.
_local_compile_c_args = []
_local_compile_cpp_args = []
_local_include_directories = []
_local_sources = []
_local_compile_definitions = []
_local_dependencies = []
_local_link_args = []
_local_link_with = []

# -----------------------------------------------------------------------------

_local_include_directories += [
  # Go back to the platform include.
  '../../include',
]

_local_sources += [
  # None.
]

# Compiler definitions must passed as options.
_local_compile_definitions += [
  '-D' + xpack_platform_compile_definition,

  # Full POSIX conformance:
  # https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap02.html#tag_02_01_03
  '-D_POSIX_C_SOURCE=200809L',

  # For S_IREAD
  '-D_GNU_SOURCE'
]

_local_compile_args += [
  # https://gcc.gnu.org/onlinedocs/gcc-11.3.0/gcc/ARM-Options.html#ARM-Options
  '-mcpu=cortex-m7',
  '-mthumb',
  '-mfloat-abi=hard',
  # '-mfloat-abi=soft',

  # '-fno-move-loop-invariants',

  # Embedded builds must be warning free.
  '-Werror',
]

if get_option('buildtype').contains('debug')
  _local_compile_args += [
    '-fno-omit-frame-pointer'
  ]
else
  _local_compile_args += [
    # -flto fails with undefined reference to `_write', `_fstat`...
    # '-flto'
  ]
endif

_local_compile_cpp_args += [
  # '-fno-exceptions',
  # '-fno-rtti',
  # '-fno-use-cxa-atexit',
  '-fno-threadsafe-statics',
]

_local_compile_c_args += common_options_dependency_compile_c_args
_local_compile_cpp_args += common_options_dependency_compile_cpp_args

_local_link_args += [
  '-v',

  '-nostartfiles',
  # '--specs=rdimon.specs', '-Wl,--start-group', '-lgcc', '-lc', '-lc', '-lm', '-lrdimon', '-Wl,--end-group',

  # Ensure the linker will keep the interrupt vectors which otherwise
  # are not referred from anywhere.
  # '-u_interrupt_vectors',

  # nano has no exceptions.
  # '-specs=nano.specs'

  '-Wl,--gc-sections',

  # Path are relative to the build folder.
  '-Txpacks/@micro-os-plus/devices-qemu-cortexm/linker-scripts/mem-mps2-an385.ld',
  '-Txpacks/@micro-os-plus/architecture-cortexm/linker-scripts/sections-flash.ld',
  # '-Txpacks/@micro-os-plus/architecture-cortexm/linker-scripts/sections-ram.ld',
]

if c_compiler.version().version_compare('>=12.0.0')
  _local_link_args += [
    # .elf has a LOAD segment with RWX permissions (GCC 12)
    '-Wl,--no-warn-rwx-segments',
  ]
endif

_local_dependencies += [
  common_options_dependency,
  micro_os_plus_devices_qemu_cortexm_dependency,
]

# https://mesonbuild.com/Reference-manual_functions.html#declare_dependency
platform_qemu_cortex_m7f_dependency = declare_dependency(
  include_directories: include_directories(_local_include_directories),
  sources: files(_local_sources),
  compile_args: _local_compile_args + _local_compile_definitions,
  dependencies: _local_dependencies,
  link_args: _local_compile_args + _local_link_args,
  link_with: _local_link_with,
)
platform_qemu_cortex_m7f_dependency_compile_c_args =  _local_compile_c_args
platform_qemu_cortex_m7f_dependency_compile_cpp_args = _local_compile_cpp_args

foreach xn : _local_include_directories
  message('+ -I ' + xn)
endforeach
# Note: depenedencies compile_args not shown.
foreach xn : _local_sources + _local_compile_definitions + _local_compile_args + _local_compile_c_args + _local_compile_cpp_args + _local_link_args
  message('+ ' + xn)
endforeach
message('> platform_qemu_cortex_m7f_dependency')

# -----------------------------------------------------------------------------
