# CMake

These files are intended as helpers during CMake builds.

## `toolchain-arm-none-eabi-gcc.cmake`

This file can be used when invoking cmake to build projects using
the `arm-none-eabi-gcc` toolchains:

```sh
cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=xpacks/micro-os-plus-build-helper/cmake/toolchain-arm-none-eabi-gcc.cmake
```

## `toolchain-riscv-none-embed-gcc.cmake`

This file can be used when invoking cmake to build projects using
the `riscv-none-embed-gcc` toolchains:

```sh
cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=xpacks/micro-os-plus-build-helper/cmake/toolchain-riscv-none-embed-gcc.cmake
```

## Other resources

- <https://cmake.org/cmake/help/v3.20/manual/cmake-variables.7.html>
- <https://cmake.org/cmake/help/v3.20/manual/cmake-generator-expressions.7.html>
- <https://cmake.org/cmake/help/v3.20/variable/CMAKE_LANG_COMPILER_ID.html>
