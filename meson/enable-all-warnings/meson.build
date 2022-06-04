# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus/)
# Copyright (c) 2022 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

message('Adding all warnings...')

global_warnings = [ ]

# This will trigger an warning.
global_warnings += [ '-Wall' ]
# The recommended way is with warning_level, but it also defines other options,
# like `-Wall -Winvalid-pch -Wnon-virtual-dtor -Wextra`
# [built-in options]
# warning_level = '1'

c_global_warnings = [ ]
cpp_global_warnings = [ ]

if c_compiler.get_id() == 'gcc'
  assert(c_compiler.version().version_compare('>=7.0.0'),
    'GNU GCC older than 7.x not supported.')

  global_warnings += [
    '-Waggregate-return',
    '-Wcast-align',
    '-Wcast-qual',
    '-Wconversion',
    '-Wdouble-promotion',
    '-Wduplicated-branches',
    '-Wduplicated-cond',
    '-Wextra',
    '-Wfloat-conversion',
    '-Wfloat-equal',
    '-Wformat-nonliteral',
    '-Wformat-overflow=2',
    '-Wformat-security',
    '-Wformat-signedness',
    '-Wformat-truncation=2',
    '-Wformat-y2k',
    '-Wformat=2',
    '-Wlogical-op',
    '-Winvalid-pch',
    '-Wmissing-declarations',
    '-Wmissing-include-dirs',
    '-Wnull-dereference',
    '-Wpacked',
    '-Wpadded',
    '-Wpointer-arith',
    '-Wredundant-decls',
    '-Wshadow',
    '-Wshift-overflow=2',
    '-Wsign-conversion',
    '-Wswitch-default',
    '-Wswitch-enum',
    '-Wundef',
    '-Wuninitialized',
    '-Wvla',
  ]

  c_global_warnings += [
    '-Wbad-function-cast',
    # '-Wc++-compat', # May break assembly builds.
    '-Wduplicate-decl-specifier',
    '-Wmissing-prototypes',
    '-Wnested-externs',
    '-Wold-style-definition',
    '-Wstrict-prototypes',
  ]

  cpp_global_warnings += [
    '-Wctor-dtor-privacy',
    '-Wnoexcept',
    '-Wnon-virtual-dtor',
    '-Wold-style-cast',
    '-Woverloaded-virtual',
    '-Wplacement-new=2',
    '-Wregister',
    '-Wsign-promo',
    '-Wstrict-null-sentinel',
    '-Wsuggest-final-methods',
    '-Wsuggest-final-types',
    '-Wsuggest-override',
    '-Wuseless-cast',
    '-Wzero-as-null-pointer-constant'
  ]

  if c_compiler.version().version_compare('>=8.0.0')
    cpp_global_warnings += [ '-Wextra-semi' ]
  endif

  if c_compiler.version().version_compare('>=10.0.0')
    c_global_warnings += [
      '-Warith-conversion'
    ]
    cpp_global_warnings += [
      '-Warith-conversion',
      '-Wcomma-subscript',
      '-Wredundant-tags',
      '-Wvolatile',
    ]
    if c_compiler.version().version_compare('=10.1.0')
      cpp_global_warnings += [ '-Wmismatched-tags' ]
    endif
  endif

elif c_compiler.get_id().contains('clang')

  c_global_warnings += [ '-Weverything' ]
  cpp_global_warnings += [ '-Weverything' ]

  # Warning observed only on Apple clang.
  c_global_warnings += [ '-Wno-poison-system-directories' ]
  cpp_global_warnings += [ '-Wno-poison-system-directories' ]

endif

add_global_arguments(
  global_warnings + c_global_warnings,
  language: 'c',
)

add_global_arguments(
  global_warnings + cpp_global_warnings,
  language: 'cpp',
)

# -----------------------------------------------------------------------------
