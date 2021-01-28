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

# This file includes various helper functions that may be used in 
# in CMake scripts.

# -----------------------------------------------------------------------------

message(STATUS "Including xpack-helper...")

# -----------------------------------------------------------------------------

# Add the `meta` and `cmake` folders to CMAKE_PREFIX_PATH.
# If an `xpacks` folder exists, iterate its children.

function(append_cmake_prefix_path path)

  set(prefix_path ${CMAKE_PREFIX_PATH})

  if(IS_DIRECTORY "${path}/meta")
    list(APPEND prefix_path "${path}/meta")
  elseif(IS_DIRECTORY "${path}/cmake")
    list(APPEND prefix_path "${path}/cmake")
  endif()

  if(EXISTS "${path}/xpacks")
    file(GLOB children "${path}/xpacks")

    foreach(child ${children})
      if(IS_DIRECTORY "${child}")
        if(IS_DIRECTORY "${child}/meta")
          list(APPEND prefix_path "${child}/meta")
        elseif(IS_DIRECTORY "${child}/cmake")
          list(APPEND prefix_path "${child}/cmake")
        endif()
      endif()
    endforeach()
  endif()

  set(CMAKE_PREFIX_PATH "${prefix_path}" PARENT_SCOPE)

endfunction()

# -----------------------------------------------------------------------------
