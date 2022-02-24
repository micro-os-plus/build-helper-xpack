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

# This file defines the global compiler settings that apply to all targets.
# Must be included with include() in the `tests` scope.

message(VERBOSE "Including platform-qemu-mps2-an386 globals...")

# -----------------------------------------------------------------------------

set(xpack_device_compile_definition "DEVICE_QEMU_CORTEX_M4")

# Global definitions.
# add_compile_definitions()
# include_directories()

set(xpack_platform_common_options

  -mcpu=cortex-m4
  -mthumb
  # -mfloat-abi=soft
  -mfloat-abi=hard

  -fno-move-loop-invariants

  # https://cmake.org/cmake/help/v3.20/manual/cmake-generator-expressions.7.html?highlight=compile_language#genex:COMPILE_LANGUAGE
  # $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-use-cxa-atexit>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>

  # -flto fails with undefined reference to `__assert_func'...
  # $<$<CONFIG:Release>:-flto>
  # $<$<CONFIG:MinSizeRel>:-flto>

  # ... libs-c/src/stdlib/exit.c:132:46
  # $<$<CXX_COMPILER_ID:GNU>:-Wno-missing-attributes>

  # Embedded builds must be warning free.
#!!  -Werror
)

add_compile_options(
  ${xpack_platform_common_options}
)

add_compile_definitions(
  # ...
  _POSIX_C_SOURCE=200809L
)

# When `-flto` is used, the compile options must be passed to the linker too.
add_link_options(
  ${xpack_platform_common_options}
)

# -----------------------------------------------------------------------------
