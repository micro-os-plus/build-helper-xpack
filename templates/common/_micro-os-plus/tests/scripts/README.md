# README

## `get-libraries-paths.sh`

To get the libraries paths, ask the compiler:

```cmake
# Compute RPATH; return result in `rpath_options_list`.
if (CMAKE_SYSTEM_NAME STREQUAL "Linux" OR CMAKE_SYSTEM_NAME STREQUAL "Darwin")
  # On non-Windows, get the actual libraries paths by asking the compiler.
  execute_process (
    COMMAND bash "${CMAKE_SOURCE_DIR}/scripts/get-libraries-paths.sh"
            ${CMAKE_CXX_COMPILER}
    OUTPUT_VARIABLE cxx_library_path
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  set (rpath_options_list)

  if (NOT "${cxx_library_path}" STREQUAL "")
    string (REPLACE ":" ";" cxx_library_path_list ${cxx_library_path})

    cmake_path (GET CMAKE_CXX_COMPILER FILENAME cxx_filename)
    message (STATUS "${cxx_filename} RPATH_LIST: ${cxx_library_path}")

    foreach (RPATH IN LISTS cxx_library_path_list)
      cmake_path (SET normalized_path NORMALIZE ${RPATH})
      list (APPEND rpath_options_list "-Wl,-rpath,${normalized_path}")
      list (APPEND rpath_options_list "-L${normalized_path}")
    endforeach ()
  endif ()
endif ()
```
