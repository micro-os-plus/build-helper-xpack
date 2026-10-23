# -----------------------------------------------------------------------------
# DO NOT EDIT! Automatically generated from template file:
# {{fromFilePath}}
#
# This file is part of the µOS++ project (https://micro-os-plus.github.io/).
# Copyright (c) {{currentYear}} Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can be
# obtained from https://opensource.org/licenses/mit.
#
# -----------------------------------------------------------------------------

# Usage: cmake -D EXECUTABLE=<path> -D OUTPUT=<file> -P capture-stdout.cmake --
# [<arg>...]
#
# Runs the executable with the arguments given after `--`, writes its standard
# output to the file, and also shows it on the standard output; the standard
# error is not captured. The trace lines of the debug builds are removed, and
# the line endings are normalised to LF. Fails if the executable returns
# non-zero.

cmake_minimum_required (VERSION 3.20)

set (arguments "")
set (after_separator FALSE)
math (EXPR last_index "${CMAKE_ARGC} - 1")
foreach (index RANGE ${last_index})
  if (after_separator)
    list (APPEND arguments "${CMAKE_ARGV${index}}")
  elseif ("${CMAKE_ARGV${index}}" STREQUAL "--")
    set (after_separator TRUE)
  endif ()
endforeach ()

execute_process (
  COMMAND "${EXECUTABLE}" ${arguments}
  OUTPUT_VARIABLE output
  RESULT_VARIABLE result
)

string (REPLACE "\r\n" "\n" output "${output}")
string (REGEX REPLACE "(^|\n)micro_os_plus::trace::[^\n]*\n" "\\1" output
                      "${output}"
)

file (WRITE "${OUTPUT}" "${output}")

# Also show the output, as it was written to the file, on the standard output;
# message() would write it to the standard error, with a prefix.
execute_process (COMMAND "${CMAKE_COMMAND}" -E cat "${OUTPUT}")

if (NOT result EQUAL 0)
  message (FATAL_ERROR "'${EXECUTABLE}' returned ${result}")
endif ()

# -----------------------------------------------------------------------------
