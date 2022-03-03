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

# This file creates the platform specific test executables.

message('Processing platform-native...')

# -----------------------------------------------------------------------------
# Define the platform library.

xpack_common_args = []
xpack_include_directories = []
xpack_sources = []
xpack_compile_definitions = []

xpack_include_directories += [
  'include-platform',
]

# https://mesonbuild.com/Reference-manual_functions.html#declare_dependency
platform_native_dependency = declare_dependency(
  include_directories: include_directories(xpack_include_directories),
  sources: files(xpack_sources),
  compile_args: xpack_common_args + xpack_compile_definitions,
  dependencies: [
    micro_os_plus_architecture_synthetic_posix_dependency
  ]
)

foreach xn : xpack_include_directories
  message('+ -I ' + xn)
endforeach
# Note: depenedencies compile_args not shown.
foreach xn : xpack_sources + xpack_common_args + xpack_compile_definitions
  message('+ ' + xn)
endforeach
message('> platform_native_dependency')

# =============================================================================

# https://mesonbuild.com/Unit-tests.html#malloc_perturb_
nomalloc = environment({'MALLOC_PERTURB_': '0'})

# -----------------------------------------------------------------------------

xpack_common_link_args = []

xpack_common_link_args += [
  # '-v',
]

if c_compiler.get_id() == 'gcc'
  xpack_common_link_args += [
    '-static-libgcc',
    '-static-libstdc++',
  ]
endif

# https://mesonbuild.com/Reference-tables.html#operating-system-names
if build_machine.system() == 'darwin'
  # macOS always uses the Apple linker, regarless of the c_compiler.
  xpack_common_link_args += [
    '-Wl,-dead_strip'
  ]
elif build_machine.system() == 'linux'
  xpack_common_link_args += [
    '-Wl,--gc-sections',
  ]
  if c_compiler.get_id().contains('clang')
    xpack_common_link_args += [
      # '-Wl,-fuse-ld=ld.gold'
    ]
  endif
else # Windows
  if c_compiler.get_id() == 'gcc'
    # TODO: clang with gold might need it too.
    xpack_common_link_args += [
      '-Wl,--gc-sections'
    ]
  elif c_compiler.get_id() == 'msvc'
    xpack_common_link_args += [
      # TODO: Add MSVC options here.
    ]
  endif
endif

# -----------------------------------------------------------------------------

xpack_common_args = []
xpack_c_args = []
xpack_cpp_args = []
xpack_include_directories = []
xpack_sources = []
xpack_compile_definitions = []
xpack_dependencies = []
xpack_link_args = []
xpack_link_with = []

xpack_include_directories += [
  '../include',
]

xpack_sources += [
  '../src/sample-test.cpp',
]

# xpack_c_args += xpack_3rd_party_xxx_yyy_dependency_c_args
# xpack_cpp_args += xpack_3rd_party_xxx_yyy_dependency_cpp_args

xpack_dependencies += [
  # Tested library.
  xpack_3rd_party_xxx_yyy_dependency,

  # Portable dependencies.
  micro_os_plus_diag_trace_dependency,

  # Platform specific dependencies.
  platform_native_dependency,
]

xpack_link_args += xpack_common_link_args

xpack_link_with += [
  # Tested library.
  # xpack_3rd_party_xxx_yyy_static,
]

# https://mesonbuild.com/Reference-manual.html#executable
sample_test = executable(
  'sample-test',
  include_directories: include_directories(xpack_include_directories),
  sources: files(xpack_sources),
  c_args: xpack_common_args + xpack_c_args + xpack_compile_definitions,
  cpp_args: xpack_common_args + xpack_cpp_args + xpack_compile_definitions,
  dependencies: xpack_dependencies,
  link_args: xpack_link_args,
  link_with: xpack_link_with,
)

foreach xn : xpack_include_directories
  message('A+ -I ' + xn)
endforeach
# Note: depenedencies compile_args not shown.
foreach xn : xpack_sources + xpack_common_args + xpack_c_args + xpack_cpp_args + xpack_compile_definitions + xpack_link_args
  message('A+ ' + xn)
endforeach
message('A> sample-test')

# -----------------------------------------------------------------------------

# https://mesonbuild.com/Reference-manual_functions.html#test
test(
  'sample-test',
  sample_test,
  args: [
    'one',
    'two'
  ],
  env: nomalloc
)

# -----------------------------------------------------------------------------

xpack_common_args = []
xpack_c_args = []
xpack_cpp_args = []
xpack_include_directories = []
xpack_sources = []
xpack_compile_definitions = []
xpack_dependencies = []
xpack_link_args = []
xpack_link_with = []

xpack_include_directories += [
  '../include',
]

xpack_sources += [
  '../src/unit-test.cpp',
]

# xpack_c_args += xpack_3rd_party_xxx_yyy_dependency_c_args
# xpack_cpp_args += xpack_3rd_party_xxx_yyy_dependency_cpp_args

xpack_dependencies += [
  # Tested library.
  xpack_3rd_party_xxx_yyy_dependency,

  # Portable dependencies.
  micro_os_plus_diag_trace_dependency,
  # micro_os_plus_micro_test_plus_dependency,

  # Platform specific dependencies.
  platform_native_dependency,
]

xpack_link_args += xpack_common_link_args

xpack_link_with += [
  # Tested library.
  xpack_3rd_party_xxx_yyy_static,
]

# https://mesonbuild.com/Reference-manual.html#executable
sample_test = executable(
  'unit-test',
  include_directories: include_directories(xpack_include_directories),
  sources: files(xpack_sources),
  c_args: xpack_common_args + xpack_c_args + xpack_compile_definitions,
  cpp_args: xpack_common_args + xpack_cpp_args + xpack_compile_definitions,
  dependencies: xpack_dependencies,
  link_args: xpack_link_args,
  link_with: xpack_link_with,
)

foreach xn : xpack_include_directories
  message('A+ -I ' + xn)
endforeach
# Note: depenedencies compile_args not shown.
foreach xn : xpack_sources + xpack_common_args + xpack_c_args + xpack_cpp_args + xpack_compile_definitions + xpack_link_args
  message('A+ ' + xn)
endforeach
message('A> sample-test')

# https://mesonbuild.com/Reference-manual_functions.html#test
test(
  'unit-test',
  unit_test,
  args: [],
  env: nomalloc
)

# -----------------------------------------------------------------------------
