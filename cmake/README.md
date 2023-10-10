# CMake

These files are intended as helpers during CMake builds.

## `toolchains/arm-none-eabi-gcc.cmake`

This file can be used when invoking cmake to build projects using
the `arm-none-eabi-gcc` toolchains:

```sh
cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=xpacks/@micro-os-plus/build-helper/cmake/toolchains/arm-none-eabi-gcc.cmake
```

## `toolchains/riscv-none-embed-gcc.cmake`

This file can be used when invoking cmake to build projects using
the `riscv-none-embed-gcc` toolchains:

```sh
cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=xpacks/@micro-os-plus/build-helper/cmake/toolchains/riscv-none-embed-gcc.cmake
```

## `get-libraries-paths.sh`

To get the libraries paths, ask the compiler:

```cmake
if (CMAKE_SYSTEM_NAME STREQUAL "Linux" OR CMAKE_SYSTEM_NAME STREQUAL "Darwin")

  # On non-Windows, get the actual libraries paths by asking the compiler.
  execute_process(
    COMMAND "${CMAKE_SOURCE_DIR}/xpacks/@micro-os-plus/build-helper/dev-scripts/get-libraries-paths.sh" ${CMAKE_CXX_COMPILER}
    OUTPUT_VARIABLE CXX_LIBRARY_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  cmake_path(GET CMAKE_CXX_COMPILER FILENAME CXX_FILENAME)
  message(VERBOSE "${CXX_FILENAME} RPATH: ${CXX_LIBRARY_PATH}")

endif()
```
## Other resources

- <https://cmake.org/cmake/help/v3.20/manual/cmake-variables.7.html>
- <https://cmake.org/cmake/help/v3.20/manual/cmake-generator-expressions.7.html>
- <https://cmake.org/cmake/help/v3.20/variable/CMAKE_LANG_COMPILER_ID.html>
