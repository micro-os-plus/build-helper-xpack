# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus/)
# Copyright (c) 2021 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# Cross compiling.
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

set(triple "riscv-none-elf-")
set(CMAKE_C_COMPILER   "${triple}gcc")
set(CMAKE_CXX_COMPILER "${triple}g++")

# Some are autodiscovered, some are not, better make them explicit.
set(CMAKE_ADDR2LINE "${triple}addr2line")
set(CMAKE_AR "${triple}ar")

set(CMAKE_ASM_COMPILER "${triple}gcc")
set(CMAKE_ASM_COMPILER_AR "${triple}gcc-ar")
set(CMAKE_ASM_COMPILER_RANLIB "${triple}gcc-ranlib")

set(CMAKE_C_COMPILER_AR "${triple}gcc-ar")
set(CMAKE_C_COMPILER_RANLIB "${triple}gcc-ranlib")

set(CMAKE_CXX_COMPILER_AR "${triple}gcc-ar")
set(CMAKE_CXX_COMPILER_RANLIB "${triple}gcc-ranlib")

set(CMAKE_LINKER "${triple}ld")

set(CMAKE_NM "${triple}nm")
set(CMAKE_OBJCOPY "${triple}objcopy")
set(CMAKE_OBJDUMP "${triple}objdump")
set(CMAKE_RANLIB "${triple}ranlib")
set(CMAKE_READELF "${triple}readelf")

# Must be explicit, not set by CMake.
set(CMAKE_SIZE "${triple}size")

set(CMAKE_STRIP "${triple}strip")

# -----------------------------------------------------------------------------

# set(CMAKE_ASM_FLAGS " -x assembler-with-cpp"
#   CACHE STRING "Flags used by the ASM compiler during all build types.")

set(CMAKE_ASM_FLAGS_DEBUG "-O0 -g3"
  CACHE STRING "Flags used by the ASM compiler during DEBUG builds.")

set(CMAKE_ASM_FLAGS_MINSIZEREL "-Os -DNDEBUG"
  CACHE STRING "Flags used by the ASM compiler during MINSIZEREL builds.")

set(CMAKE_ASM_FLAGS_RELEASE "-O3 -DNDEBUG"
  CACHE STRING "Flags used by the ASM compiler during RELEASE builds.")

set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "-O2 -g3 -DNDEBUG"
  CACHE STRING "Flags used by the ASM compiler during RELWITHDEBINFO builds.")

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
