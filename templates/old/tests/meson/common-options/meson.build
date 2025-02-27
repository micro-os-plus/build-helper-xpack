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
## Common definitions for all platforms ##

message('Including tests/meson/common-options/meson.build...')

_local_compile_args = [] # Common C/C++ args.
_local_compile_c_args = []
_local_compile_cpp_args = []
_local_include_directories = []
_local_sources = []
_local_compile_definitions = []
_local_dependencies = []
_local_link_args = []
_local_link_with = []

# Assume GCC or clang, for MSVC things are different
# https://mesonbuild.com/Reference-tables.html#c_compiler-ids
if c_compiler.get_id() == 'gcc' or c_compiler.get_id().contains('clang')

  # Global compiler preprocessor definitions.
  # Native builds may not use them.
  if get_option('buildtype').contains('debug')
    _local_compile_definitions += [ '-DDEBUG' ]
    _local_compile_definitions += [ '-DMICRO_OS_PLUS_DEBUG' ]
    _local_compile_definitions += [ '-DMICRO_OS_PLUS_TRACE' ]
  endif
  if get_option('buildtype') == 'release'
    _local_compile_definitions += [ '-DNDEBUG' ]
  endif
  _local_compile_definitions += [ '-DMICRO_OS_PLUS_INCLUDE_CONFIG_H' ]

  # DO NOT define it globally, one test does not need it!
  # _local_compile_definitions += ['-DMICRO_OS_PLUS_TRACE']

  # Options for both compilers and linkers. When using `-flto`, all options
  # must also be passed to the linker.

  if get_option('buildtype') == 'debug'
    # _local_compile_args += [ '-O0' ]
  elif get_option('buildtype') == 'debugoptimized'
    _local_compile_args += [ '-Og' ] # Override -O2
  elif get_option('buildtype') == 'minsize'
    # _local_compile_args += [ '-Os' ]
  elif get_option('buildtype') == 'release'
    # _local_compile_args += [ '-O3' ]
  else
    _local_compile_args += [ '-O' ]
  endif

  _local_compile_args += [
    '-fmessage-length=0',
    '-fsigned-char',

    # These are used in conjunction with linker `--gc-sections`.
    '-ffunction-sections',
    '-fdata-sections'
  ]

  common_options_dependency = declare_dependency(
    include_directories: include_directories(_local_include_directories),
    sources: files(_local_sources),
    compile_args: _local_compile_args + _local_compile_definitions,
    # When `-flto` is used, the compile options must be passed to the linker too.
    dependencies: _local_dependencies,
    link_args: _local_compile_args + _local_link_args,
    link_with: _local_link_with,
  )
  common_options_dependency_compile_c_args = _local_compile_c_args
  common_options_dependency_compile_cpp_args = _local_compile_cpp_args

  foreach xn : _local_include_directories
    message('G+ -I ' + xn)
  endforeach
  foreach xn : _local_sources + _local_compile_definitions + _local_compile_args + _local_compile_c_args + _local_compile_cpp_args + _local_link_args
    message('G+ ' + xn)
  endforeach

  # Warnings must be included from the tests.

else
  message('Unsupported compiler')
endif

# -----------------------------------------------------------------------------
