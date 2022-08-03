[![license](https://img.shields.io/github/license/xpack-3rd-party/xxx-yyy-xpack)](https://github.com/xpack-3rd-party/xxx-yyy-xpack/blob/xpack/LICENSE)
[![CI on Push](https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/workflows/CI.yml/badge.svg)](https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/workflows/CI.yml)

# A source library xPack with XXXX YYYY

Note: this project is work in progress.

This project provides the **XXXX YYYY** source library as an xPack dependency.

The project is hosted on GitHub as
[xpack-3rd-party/xxx-yyy-xpack](https://github.com/xpack-3rd-party/xxx-yyy-xpack).

## Maintainer info

This page is addressed to developers who plan to include this source
library into their own projects.

For maintainer info, please see the
[README-MAINTAINER-XPACK](README-MAINTAINER-XPACK.md) file.

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
[`@xpack-3rd-party/xxx-yyy`](https://www.npmjs.com/package/@xpack-3rd-party/xxx-yyy)
from the `npmjs.com` registry:

```sh
cd my-project
xpm init # Unless a package.json is already present

xpm install @xpack-3rd-party/xxx-yyy@latest

ls -l xpacks/xpack-3rd-party-xxx-yyy
```

### Git submodule

If, for any reason, **xpm** is not available, the next recommended
solution is to link it as a Git submodule below an `xpacks` folder.

```sh
cd my-project
git init # Unless already a Git project
mkdir -p xpacks

git submodule add https://github.com/xpack-3rd-party/xxx-yyy-xpack.git \
  xpacks/xpack-3rd-party-xxx-yyy
```

## Branches

There are three active branches:

- `master`, follows the original Arm `master`
- `xpack`, with the latest stable version (default)
- `xpack-develop`, with the current development version

All development is done in the `xpack-develop` branch, and contributions via
Pull Requests should be directed to this branch. (Only contributions
related to the xPack integration are accepted, functional contributions
should be addressed to the upstream project.)

When new releases are published, the `xpack-develop` branch is merged
into `xpack`.

## Developer info

### Overview

This package provides the full XXXX YYYY code, but when
installed via xpm the content is filtered and only the
.... folders are used.

In addition to the source files, the
configuration files required to integrate it into
CMake and meson projects, by building a static library.

### Status

The **xxx-yyy** source library is fully functional.

### Build & integration info

The project is written in C++, and it is expected to be used in C++ projects.
The source code was compiled with GCC 11, clang 12, clang 12
and arm-none-eabi-gcc 10, and should be warning free.

To ease the integration of this package into user projects, there
are already made CMake and meson configuration files (see below).

For other build systems, consider the following details:

#### Include folders

The following folders should be passed to the compiler during the build:

- `include`

The header files can then be included in user projects with statements like:

```c++
#include "xxx/yyy.h"
```

#### Source files

The source files to be added to user projects are:

- `src/xxx-yyy.cpp`

#### Preprocessor definitions

There are several preprocessor definitions used to configure the build.

For embedded platforms, use:

- `-D_POSIX_C_SOURCE=200809L`

This will enable POSIX support in newlib.

#### Compiler options

- `-std=c++20` or higher for C++ sources
- `-std=c11` for C sources

#### C++ Namespaces

- `...`

#### C++ Classes

The project includes many classes; see the documentation for details.

#### Dependencies

- none

#### CMake

To integrate the Google Test source library into a CMake application,
add this folder to the build:

```cmake
add_subdirectory("xpacks/xpack-3rd-party-xxx-yyy")`
```

The result is a static library that can be added as an application
dependency with:

```cmake
target_link_libraries(your-target PRIVATE
  ...
  xpack-3rd-party::xxx-yyy
)
```

#### meson

To integrate the Google Test source library into a meson application,
add this folder to the build:

```meson
subdir('xpacks/xpack-3rd-party-xxx-yyy')
```

The result is a static library and a dependency object that can be added
as an application dependency with:

```meson
exe = executable(
  your-target,

  c_args: xpack_3rd_party_xxx_yyy_dependency_c_args,
  cpp_args: xpack_3rd_party_xxx_yyy_dependency_cpp_args,
  dependencies: [
    xpack_3rd_party_xxx_yyy_dependency,
  ],
  link_with: [
    xpack_3rd_party_xxx_yyy_static,
  ],
)
```

### Example

A simple example showing how to use the Google Test framework is
presented below and is also available in
[tests-xpack/src/sample-test.cpp](tests-xpack/src/sample-test.cpp).

```c++
#include "xxx/yyy.h"

// ...

int
main ([[maybe_unused]] int argc, [[maybe_unused]] char* argv[])
{
  return 0;
}
```

### Known problems

- none

### Tests

The project is fully tested via GitHub
[Actions](https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/)
on each push.
The test platforms are GNU/Linux, macOS and Windows, the tests are
compiled with GCC, clang and arm-none-eabi-gcc and run natively or
via QEMU.

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

### Documentation

Tho original documentation is available on-line:

- <https:.../>

## Change log - incompatible changes

According to [semver](https://semver.org) rules:

> Major version X (X.y.z | X > 0) MUST be incremented if any
backwards incompatible changes are introduced to the public API.

The incompatible changes, in reverse chronological order,
are:

- v1.x: initial release

## License

The xPack content is released under the
[MIT License](https://opensource.org/licenses/MIT/),
with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul/).

The upstream content is provided under the terms of the ... .

---

The original README content follows.
