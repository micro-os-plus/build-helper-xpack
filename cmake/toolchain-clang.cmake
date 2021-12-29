#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2021 Liviu Ionescu
#
# This Source Code Form is subject to the terms of the MIT License.
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

set(CMAKE_C_COMPILER   "clang")
set(CMAKE_CXX_COMPILER "clang++")

# Some are autodiscovered, some are not, better make them explicit.
set(CMAKE_ADDR2LINE "llvm-addr2line")
set(CMAKE_AR "llvm-ar")
set(CMAKE_ASM_COMPILER "clang")
set(CMAKE_ASM_COMPILER_AR "llvm-ar")
set(CMAKE_ASM_COMPILER_RANLIB "llvm-ranlib")
set(CMAKE_DLLTOOL "llvm-dlltool")
set(CMAKE_NM "llvm-nm")
set(CMAKE_OBJCOPY "llvm-objcopy")
set(CMAKE_OBJDUMP "llvm-objdump")
set(CMAKE_RANLIB "llvm-ranlib")
set(CMAKE_READELF "llvm-readelf")
set(CMAKE_SIZE "llvm-size") # Must be explicit, not set by CMake.

# -----------------------------------------------------------------------------

# TODO: remove workaround once VS Code is fixed.
# VS Code does not properly identify the shims used by npm/xpm,
# thus make the extension explicit.
if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Windows")
  set(CMAKE_C_COMPILER "${CMAKE_C_COMPILER}.cmd")
  set(CMAKE_CXX_COMPILER "${CMAKE_CXX_COMPILER}.cmd")
endif()

# -----------------------------------------------------------------------------

# TODO: understand why CMAKE_<lang>_OUTPUT_EXTENSION is not effective

set(CMAKE_ASM_FLAGS " -x assembler-with-cpp"
  CACHE STRING "Flags used by the ASM compiler during all build types.")

set(CMAKE_ASM_FLAGS_DEBUG "-O0 -g3"
  CACHE STRING "Flags used by the ASM compiler during DEBUG builds.")

set(CMAKE_ASM_FLAGS_MINSIZEREL "-Os -DNDEBUG"
  CACHE STRING "Flags used by the ASM compiler during MINSIZEREL builds.")

set(CMAKE_ASM_FLAGS_RELEASE "-O3 -DNDEBUG"
  CACHE STRING "Flags used by the ASM compiler during RELEASE builds.")

set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "-O2 -g3 -DNDEBUG"
  CACHE STRING "Flags used by the ASM compiler during RELWITHDEBINFO builds.")

# Not effective.
set(CMAKE_ASM_OUTPUT_EXTENSION ".o")

set(CMAKE_C_FLAGS
  CACHE STRING "Flags used by the C compiler during all build types.")

set(CMAKE_C_FLAGS_DEBUG "-O0 -g3"
  CACHE STRING "Flags used by the C compiler during DEBUG builds.")

set(CMAKE_C_FLAGS_MINSIZEREL "-Os -DNDEBUG"
  CACHE STRING "Flags used by the C compiler during MINSIZEREL builds.")

set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG"
  CACHE STRING "Flags used by the C compiler during RELEASE builds.")

set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g3 -DNDEBUG"
  CACHE STRING "Flags used by the C compiler during RELWITHDEBINFO builds.")

# Not effective.
set(CMAKE_C_OUTPUT_EXTENSION ".o")

set(CMAKE_CXX_FLAGS
  CACHE STRING "Flags used by the CXX compiler during all build types.")

set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3"
  CACHE STRING "Flags used by the CXX compiler during DEBUG builds.")

set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG"
  CACHE STRING "Flags used by the CXX compiler during MINSIZEREL builds.")

set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG"
  CACHE STRING "Flags used by the CXX compiler during RELEASE builds.")

set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g3 -DNDEBUG"
  CACHE STRING "Flags used by the CXX compiler during RELWITHDEBINFO builds.")

# Not effective.
set(CMAKE_CXX_OUTPUT_EXTENSION ".o")
# set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE 1)

set(CMAKE_EXE_LINKER_FLAGS
  CACHE STRING "Flags used by the linker during all build types.")

# Disabled, since apparently CMake already uses the C/CXX flags,
# and defining them here will double them.
if(0)
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "-O0 -g3"
  CACHE STRING "Flags used by the linker during DEBUG builds.")

set(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL "-Os"
  CACHE STRING "Flags used by the linker during MINSIZEREL builds.")

set(CMAKE_EXE_LINKER_FLAGS_RELEASE "-O3"
  CACHE STRING "Flags used by the linker during RELEASE builds.")

set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "-O2 -g3"
  CACHE STRING "Flags used by the linker during RELWITHDEBINFO builds.")
endif()

# -----------------------------------------------------------------------------
