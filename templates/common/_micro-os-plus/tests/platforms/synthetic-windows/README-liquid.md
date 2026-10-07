# platforms/synthetic-windows

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building applications to run as native processes on Windows.

Note: Work in progress!

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
the `@micro-os-plus/architecture-synthetic-windows` package.

## Toolchains and other binary tools

The tests are compiled with multiple versions of xPack GCC.

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

### Windows

Windows is a special case, since the DLLs referred by the generated binaries
are generally not available in the standard distribution and the toolchain
provided libraries are mandatory.

Separate libraries are available for 64/32-bit binaries, in the
`x86_64-w64-mingw32/lib`, respectively `i686-w64-mingw32/lib`,
when available.

The actual location of the C++ libraries can be obtained by asking
the C++ compiler, for example with `-print-file-name=<library>.dll`.

This path can be later used to adjust the environment PATH to include
the libraries.

However, in order to simplify things, the Windows builds use `-static`.

## Coverage

Currently coverage is implemented only on macOS and uses the system
`llvm-cov`.
