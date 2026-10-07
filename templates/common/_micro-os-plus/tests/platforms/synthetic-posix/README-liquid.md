# platforms/synthetic-posix

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building applications to run as native processes on POSIX
systems, like macOS and GNU/Linux.

## Include folders

The following folders should be passed to the compiler during the build:

- `include`

The header files to be included in user projects are:

```cpp
#include "micro-os-plus/platform.h"
```

## Source files

The source files to be added to user projects are:

- none

## Device & architecture definitions

The native definitions for the device and architecture are in
the `@micro-os-plus/architecture-synthetic-posix` package.

## Toolchains and other binary tools

The tests are compiled with system toolchains (on macOS and GNU/Linux)
and with multiple versions of xPack GCC and xPack clang.

Other tools used are

- xPack CMake
- xPack meson
- xPack ninja

## Shared libraries

Binaries compiled by toolchains installed in custom locations
(like xPack GCC and xPack clang)
require explicitly referring to the shared libraries specific to the
toolchain, and it is important to avoid using the similar system
libraries, since sometimes they might not be compatible.

### GNU/Linux & macOS

For GNU/Linux & macOS builds, the compiler is asked the locations of the
libraries, and this list of paths is passed to the linker as `-rpath`.

Although CMake can directly define sequences of piped commands, meson
can not, and requires an external script, available as
`scripts/get-libraries-paths.mjs`.

It requires the name of the compiler (clang++ or g++).

## Coverage

Currently coverage is implemented only on macOS and uses the system
`llvm-cov`.

To enable it, set `XPACK_ENABLE_COVERAGE` to `true` in `CMakeLists.txt`.

To show coverage for a single file, add the relative path as the 3rd
argument to `show-coverage.sh`, prefixed by `../../../../`:

```txt
"../../../../src/doubly-list-links.cpp"
```
