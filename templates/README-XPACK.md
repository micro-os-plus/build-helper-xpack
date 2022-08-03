[![GitHub package.json version](https://img.shields.io/github/package-json/v/micro-os-plus/xxx-yyy-xpack)](https://github.com/micro-os-plus/xxx-yyy-xpack/blob/xpack/package.json)
[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/micro-os-plus/xxx-yyy-xpack)](https://github.com/micro-os-plus/xxx-yyy-xpack/tags/)
[![npm (scoped)](https://img.shields.io/npm/v/@micro-os-plus/xxx-yyy.svg?color=blue)](https://www.npmjs.com/package/@micro-os-plus/xxx-yyy/)
[![license](https://img.shields.io/github/license/micro-os-plus/xxx-yyy-xpack)](https://github.com/micro-os-plus/xxx-yyy-xpack/blob/xpack/LICENSE)
[![CI on Push](https://github.com/micro-os-plus/xxx-yyy-xpack/actions/workflows/CI.yml/badge.svg)](https://github.com/micro-os-plus/xxx-yyy-xpack/actions/workflows/CI.yml)

# A source library xPack with XXXX YYYY

This project provides the **xxx-yyy** source library as an xPack
dependency and includes ...

The project is hosted on GitHub as
[micro-os-plus/xxx-yyy-xpack](https://github.com/micro-os-plus/xxx-yyy-xpack).

## Maintainer info

This page is addressed to developers who plan to include this source
library into their own projects.

For maintainer info, please see the
[README-MAINTAINER](README-MAINTAINER.md) file.

## Install

As a source library xPack, the easiest way to add it to a project is via
**xpm**, but it can also be used as any Git project, for example as a submodule.

### Prerequisites

A recent [xpm](https://xpack.github.io/xpm/),
which is a portable [Node.js](https://nodejs.org/) command line application.

It is recommended to update to the latest version with:

```sh
npm install --global xpm@latest
```

For details please follow the instructions in the
[xPack install](https://xpack.github.io/install/) page.

### xpm

This package is available from npmjs.com as
[`@micro-os-plus/xxx-yyy`](https://www.npmjs.com/package/@micro-os-plus/xxx-yyy)
from the `npmjs.com` registry:

```sh
cd my-project
xpm init # Unless a package.json is already present

xpm install @micro-os-plus/xxx-yyy@latest

ls -l xpacks/micro-os-plus-xxx-yyy
```

### Git submodule

If, for any reason, **xpm** is not available, the next recommended
solution is to link it as a Git submodule below an `xpacks` folder.

```sh
cd my-project
git init # Unless already a Git project
mkdir -p xpacks

git submodule add https://github.com/micro-os-plus/xxx-yyy-xpack.git \
  xpacks/micro-os-plus-xxx-yyy
```

## Branches

Apart from the unused `master` branch, there are two active branches:

- `xpack`, with the latest stable version (default)
- `xpack-develop`, with the current development version

All development is done in the `xpack-develop` branch, and contributions via
Pull Requests should be directed to this branch.

When new releases are published, the `xpack-develop` branch is merged
into `xpack`.

## Developer info

### Overview

This source xPack provides ...

### Status

The **xxx-yyy** source library is fully functional.

The xxx classes are used to ...

### C++ API

The C++ methods available for the xxx are:

```c++
...
```

### C API

The following C functions are available:

```c
```

[or]

There are no C equivalents for the C++ methods.

### Build & integration info

The project is written in C++ [and assembly] and it is expected
to be used in [C and] C++ projects.

The source code was compiled with GCC 11, clang 12, clang 13
arm-none-eabi-gcc 11, riscv-none-elf-gcc 12, and should be warning free.

To ease the integration of this package into user projects, there
are already made CMake and meson configuration files (see below).

For other build systems, consider the following details:

#### Include folders

The following folders should be passed to the compiler during the build:

- `include`

The header files to be included in user projects are:

```c++
#include <micro-os-plus/xxx/yyy.h>
```

#### Source files

The source files to be added to user projects are:

- `src/xxx-yyy.cpp`

#### Preprocessor definitions

For the build to pass, the following definitions should be passed to the
complier:

- `_XOPEN_SOURCE=700L`

To configure the build, the following preprocessor definitions can be used:

- `MICRO_OS_PLUS_INCLUDE_CONFIG_H` - to include `<micro-os-plus/config.h>`
- `...`

[or]

- none

#### Compiler options

- `-std=c++20` or higher for C++ sources
- `-std=c11` for C sources

#### C++ Namespaces

- `micro_os_plus::xxx`

[or]

- none

#### C++ Classes

```c++
...
```

[or]

- none

#### Dependencies

- the `@micro-os-plus/diag-trace` package, for the trace definitions.

[or]

- none

#### CMake

To integrate the xxx-yyy source library into a CMake application,
add this folder to the build:

```cmake
add_subdirectory("xpacks/micro-os-plus-xxx-yyy")`
```

The result is an interface library that can be added as an application
dependency with:

```cmake
target_link_libraries(your-target PRIVATE

  micro-os-plus::xxx-yyy
)
```

#### meson

To integrate the xxx-yyy source library into a meson application,
add this folder to the build:

```meson
subdir('xpacks/micro-os-plus-xxx-yyy')
```

The result is a dependency object that can be added
to an application with:

```meson
exe = executable(
  your-target,
  link_with: [
    # Nothing, not static.
  ],
  dependencies: [
    micro_os_plus_xxx_yyy_dependency,
  ]
)
```

### Examples

An example showing how to use the xxx is
available in
[tests/src/sample-test.cpp](tests/src/sample-test.cpp).

Here are some excerpts:

```c++
#include <micro-os-plus/xxx/yyy.h>

...
```

### Known problems

- none

### Tests

The project is fully tested via GitHub
[Actions](https://github.com/micro-os-plus/xxx-yyy-xpack/actions/)
on each push.

The test platforms are GNU/Linux, macOS and Windows; native tests are
compiled with GCC and clang; tests for embedded platforms are compiled
with arm-none-eabi-gcc and risc-none-elf-gcc, and executed via QEMU.

There are two sets of tests, one that runs on every push, with a
limited number of tests, and a set that is triggered manually,
usually before releases, and runs all tests on all supported
platforms.

The full set can be run manually with the following commands:

```sh
cd ~Work/xxx-yyy-xpack.git

xpm run install-all
xpm run test-all
```

## Change log - incompatible changes

According to [semver](https://semver.org) rules:

> Major version X (X.y.z | X > 0) MUST be incremented if any
backwards incompatible changes are introduced to the public API.

The incompatible changes, in reverse chronological order, are:

- v1.x: initial code.

## Credits

Many thanks to ...

## License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT/),
with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul/).
