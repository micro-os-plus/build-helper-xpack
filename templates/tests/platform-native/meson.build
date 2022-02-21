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

# This file creates the platform specific test executables.

message('Processing platform-native...')

# -----------------------------------------------------------------------------
# Define the platform library.

# https://mesonbuild.com/Reference-manual_functions.html#declare_dependency
platform_native_dependency = declare_dependency(
  include_directories: include_directories(
    'include-platform',
  ),
  sources: files(
  ),
  compile_args: [
  ],
  dependencies: [
    micro_os_plus_architecture_synthetic_posix_dependency
  ]
)

message('+ -I tests/platform-native/include-platform')
message('+ tests/platform-native/src/trace-posix.cpp')
message('> platform_native_dependency')

# =============================================================================

linker_options = [
  # '-v',
]

if c_compiler.get_id() == 'gcc'
  linker_options += [
    '-static-libgcc',
    '-static-libstdc++',
  ]
endif

# https://mesonbuild.com/Reference-tables.html#operating-system-names
if build_machine.system() == 'darwin'
  # macOS always uses the Apple linker, regarless of the c_compiler.
  linker_options += [
    '-Wl,-dead_strip'
  ]
elif build_machine.system() == 'linux'
  linker_options += [
    '-Wl,--gc-sections'
  ]
  if c_compiler.get_id().contains('clang')
    linker_options += [
      # '-Wl,-fuse-ld=ld.gold'
    ]
  endif
else # Windows
  if c_compiler.get_id() == 'gcc'
    # TODO: clang with gold might need it too.
    linker_options += [
      '-Wl,--gc-sections'
    ]
  elif c_compiler.get_id() == 'msvc'
    linker_options += [
      # TODO: Add MSVC options here.
    ]
  endif
endif

# -----------------------------------------------------------------------------

# https://mesonbuild.com/Unit-tests.html#malloc_perturb_
nomalloc = environment({'MALLOC_PERTURB_': '0'})

# -----------------------------------------------------------------------------

# https://mesonbuild.com/Reference-manual.html#executable
sample_test = executable(
  'sample-test',
  include_directories: include_directories(
    '../include',
  ),
  sources: files(
    '../src/sample-test.cpp'
  ),
  c_args: [ ],
  cpp_args: [ ],
  dependencies: [
    # Tested library.
    micro_os_plus_xxx_yyy_dependency,

    # Portable dependencies.
    micro_os_plus_diag_trace_dependency,

    # Platform specific dependencies.
    platform_native_dependency,
  ],
  link_args: linker_options
)

message('A+ -I tests/include')
message('A+ tests/src/sample-test.cpp')
message('A> sample-test')

# https://mesonbuild.com/Reference-manual_functions.html#test
test(
  'sample-test',
  sample_test,
  args: [],
  env: nomalloc
)

# -----------------------------------------------------------------------------

# https://mesonbuild.com/Reference-manual.html#executable
unit_test = executable(
  'unit-test',
  include_directories: include_directories(
    '../include',
  ),
  sources: files(
    '../src/unit-test.cpp'
  ),
  c_args: [ ],
  cpp_args: [ ],
  dependencies: [
    # Tested library.
    micro_os_plus_xxx_yyy_dependency,

    # Portable dependencies.
    micro_os_plus_diag_trace_dependency,
    micro_os_plus_micro_test_plus_dependency,

    # Platform specific dependencies.
    platform_native_dependency,
  ],
  link_args: linker_options
)

message('A+ -I tests/include')
message('A+ tests/src/unit-test.cpp')
message('A> unit-test')

# https://mesonbuild.com/Reference-manual_functions.html#test
test(
  'unit-test',
  unit_test,
  args: [],
  env: nomalloc
)

# -----------------------------------------------------------------------------
