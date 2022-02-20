#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2022 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------
## Common definitions for all platforms ##

# Assume GCC or clang, for MSVC things are different
# https://mesonbuild.com/Reference-tables.html#c_compiler-ids
if c_compiler.get_id() == 'gcc' or c_compiler.get_id().contains('clang')

  includes = []
  # Always add the `include-config` folder.
  includes += [ '-I../../tests/platform-' + xpack_platform_name + '/include-config' ]
  message('G+ -I tests/platform-' + xpack_platform_name + '/include-config')

  # Global compiler preprocessor definitions.
  # Native builds may not use them.
  compiler_definitions = []
  if get_option('buildtype').contains('debug')
    compiler_definitions += [ '-DDEBUG' ]
    compiler_definitions += [ '-DMICRO_OS_PLUS_DEBUG' ]
    compiler_definitions += [ '-DMICRO_OS_PLUS_TRACE' ]
  endif
  if get_option('buildtype') == 'release'
    compiler_definitions += [ '-DNDEBUG' ]
  endif
  compiler_definitions += [ '-DMICRO_OS_PLUS_INCLUDE_CONFIG_H' ]

  # DO NOT define it globally, one test does not need it!
  # compiler_definitions += ['-DMICRO_OS_PLUS_TRACE']

  # Options for both compilers and linkers. When using `-flto`, all options
  # must also be passed to the linker.

  global_common_options = []
  if get_option('buildtype') == 'debug'
    # global_common_options += [ '-O0' ]
  elif get_option('buildtype') == 'debugoptimized'
    global_common_options += [ '-Og' ] # Override -O2
  elif get_option('buildtype') == 'minsize'
    # global_common_options += [ '-Os' ]
  elif get_option('buildtype') == 'release'
    # global_common_options += [ '-O3' ]
  else
    global_common_options += [ '-O' ]
  endif

  global_common_options += [
    '-fmessage-length=0',
    '-fsigned-char',

    # These are used in conjunction with linker `--gc-sections`.
    '-ffunction-sections',
    '-fdata-sections'
  ]

  add_global_arguments(
    includes + compiler_definitions + global_common_options,

    language: [ 'c', 'cpp' ]
  )

  # When `-flto` is used, the compile options must be passed to the linker too.
  add_global_link_arguments(
    global_common_options,

    language: [ 'c', 'cpp' ]
  )

  # Warnings must be included from the tests.

else
  message('Unsupported compiler')
endif

# -----------------------------------------------------------------------------
