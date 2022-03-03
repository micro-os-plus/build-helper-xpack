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

# Definitions required for compiling all files, thus the use of
# add_global_*() functions.
# Must be added with subdir() before creating any library or executable.

message('Including platform-native global definitions...')

# -----------------------------------------------------------------------------

xpack_platform_common_args = []
xpack_platform_common_c_args = []
xpack_platform_common_cpp_args = []
xpack_platform_compile_definitions = []

if c_compiler.get_id().contains('clang') and build_machine.system() == 'darwin'
  # On macOS enabling the macro fails with:
  # error: unknown type name 'u_int'
else
  xpack_platform_compile_definitions += [
    '-D_POSIX_C_SOURCE=200809L',
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
    xpack_platform_common_args += [
      '-flto',
    ]
  endif
endif

add_global_arguments(
  xpack_platform_common_args + xpack_platform_common_c_args + xpack_platform_compile_definitions,

  language: [ 'c' ]
)

add_global_arguments(
  xpack_platform_common_args + xpack_platform_common_cpp_args + xpack_platform_compile_definitions,

  language: [ 'cpp' ]
)

foreach xn : xpack_platform_common_args + xpack_platform_common_c_args + xpack_platform_common_cpp_args + xpack_platform_compile_definitions
  message('G+ ' + xn)
endforeach

# When `-flto` is used, the compile options must be passed to the linker too.
add_global_link_arguments(
  xpack_platform_common_args + xpack_platform_common_c_args,

  language: [ 'c' ]
)

# When `-flto` is used, the compile options must be passed to the linker too.
add_global_link_arguments(
  xpack_platform_common_args + xpack_platform_common_cpp_args,

  language: [ 'cpp' ]
)

# -----------------------------------------------------------------------------

# The base folder is root, via the `top` link.
xpack_dependencies = [
  'xpacks/micro-os-plus-diag-trace', # -
  xpack_build_folder_relative_path + '/xpacks/micro-os-plus-architecture-synthetic-posix', # (architecture) -

  # 'xpacks/micro-os-plus-micro-test-plus', # -
]

# -----------------------------------------------------------------------------
