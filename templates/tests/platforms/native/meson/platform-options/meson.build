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

if build_machine.system() == 'linux' or build_machine.system() == 'darwin'

  _local_cxx_library_path = run_command(
    xpack_tests_folder_path + '/xpacks/@micro-os-plus/build-helper/dev-scripts/get-libraries-paths.sh',
    cpp_compiler.cmd_array()[0],
    check: false,
    capture: true
  ).stdout().strip().split(':')

  message('RPATH_LIST:')
  _local_rpath_options_list = []
  foreach _local_rpath : _local_cxx_library_path
    _local_rpath_options_list += '-Wl,-rpath,' + _local_rpath
    message('-Wl,-rpath,' + _local_rpath)
  endforeach

endif

# -----------------------------------------------------------------------------

# Define the platform library.

_local_compile_args = [] # Common C/C++ args.
_local_compile_c_args = []
_local_compile_cpp_args = []
_local_include_directories = []
_local_sources = []
_local_compile_definitions = []
_local_dependencies = []
_local_link_args = []
_local_link_with = []

_local_include_directories += [
  # Go back to the platform include.
  '../../include',
]

_local_sources += [
  # None.
]

_local_compile_definitions += [
  '-D' + xpack_platform_compile_definition,

  # Full POSIX conformance:
  # https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap02.html#tag_02_01_03
  '-D_POSIX_C_SOURCE=200809L',
]

# if c_compiler.get_id().contains('clang') and build_machine.system() == 'darwin'
#   # On macOS enabling the macro fails with:
#   # error: unknown type name 'u_int'
# else
#   _local_compile_definitions += [
#   ]
# endif

_local_compile_args += [
  '-Werror',
]

if build_machine.system() == 'darwin'
  _local_compile_args += [
    '-Wno-missing-include-dirs',
  ]
endif

if c_compiler.get_id().contains('clang') and build_machine.system() == 'windows'
  _local_compile_args += [
    '-Wno-used-but-marked-unused',
  ]
endif

if get_option('buildtype') == 'release' or get_option('buildtype') == 'minsize' or get_option('buildtype') == 'debugoptimized'
  # https://mesonbuild.com/Reference-tables.html#operating-system-names
  # message(build_machine.cpu())
  # Match armv[78]l.
  if c_compiler.get_id().contains('clang') and build_machine.system() == 'linux' and build_machine.cpu().contains('armv')
    # clang-12: error: unable to execute command: Segmentation fault
    # clang-12: error: linker command failed due to signal (use -v to see invocation)
  else
    # meson-out/sample-test.p/.._src_sample-test.cpp.o: file not recognized: file format not recognized
    _local_compile_args += [
      '-flto',
    ]
  endif
endif

if c_compiler.get_id().contains('clang')
  _local_compile_cpp_args += [
    '-stdlib=libc++'
  ]
endif

_local_compile_c_args += common_options_dependency_compile_c_args
_local_compile_cpp_args += common_options_dependency_compile_cpp_args

_local_link_args += [
  # '-v',
]

if c_compiler.get_id().contains('clang')
  _local_link_args += [
    '-stdlib=libc++',
    '-rtlib=compiler-rt'
  ]
  if build_machine.system() == 'linux'
    _local_link_args += [
      '-lunwind',
      '-fuse-ld=lld'
    ]
  endif
endif

# if c_compiler.get_id() == 'gcc'
#   _local_link_args += [
#     '-static-libgcc',
#     '-static-libstdc++',
#   ]
# endif

# https://mesonbuild.com/Reference-tables.html#operating-system-names
if build_machine.system() == 'darwin'
  _local_link_args += _local_rpath_options_list
  # macOS always uses the Apple linker, regarless of the c_compiler.
  _local_link_args += [
    '-Wl,-dead_strip'
  ]

  # Workaround for new linker bug in CLT/Xcode 15.0.
  # ld: Assertion failed: (resultIndex < sectData.atoms.size()), function findAtom, file Relocations.cpp, line 1336.
  if c_compiler.get_id() == 'gcc'
    _local_link_args += [
      '-no-pie'
    ]
  endif
elif build_machine.system() == 'linux'
  _local_link_args += _local_rpath_options_list
  _local_link_args += [
    '-Wl,--gc-sections',
  ]
  if c_compiler.get_id().contains('clang')
    _local_link_args += [
      # '-Wl,-fuse-ld=ld.gold'
    ]
  endif
else # Windows
  _local_link_args += [
    '-static',
  ]
  if c_compiler.get_id() == 'gcc'
    # TODO: clang with gold might need it too.
    _local_link_args += [
      '-Wl,--gc-sections'
    ]
  elif c_compiler.get_id() == 'msvc'
    _local_link_args += [
      # TODO: Add MSVC options here.
    ]
  endif
endif

_local_dependencies += [
  common_options_dependency,
  micro_os_plus_architecture_synthetic_posix_dependency
]

# https://mesonbuild.com/Reference-manual_functions.html#declare_dependency
platform_native_dependency = declare_dependency(
  include_directories: include_directories(_local_include_directories),
  sources: files(_local_sources),
  compile_args: _local_compile_args + _local_compile_definitions,
  dependencies: _local_dependencies,
  link_args: _local_compile_args + _local_link_args,
  link_with: _local_link_with,
)
platform_native_dependency_compile_c_args =  _local_compile_c_args
platform_native_dependency_compile_cpp_args = _local_compile_cpp_args

foreach xn : _local_include_directories
  message('+ -I ' + xn)
endforeach
# Note: depenedencies compile_args not shown.
foreach xn : _local_sources + _local_compile_definitions + _local_compile_args + _local_compile_c_args + _local_compile_cpp_args + _local_link_args
  message('+ ' + xn)
endforeach
message('> platform_native_dependency')

# -----------------------------------------------------------------------------
