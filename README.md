[![GitHub package.json version](https://img.shields.io/github/package-json/v/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/blob/xpack/package.json)
[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/tags/)
[![npm (scoped)](https://img.shields.io/npm/v/@micro-os-plus/build-helper.svg?color=blue)](https://www.npmjs.com/package/@micro-os-plus/build-helper/)
[![license](https://img.shields.io/github/license/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/blob/xpack/LICENSE)
[![CI on Push](https://github.com/micro-os-plus/build-helper-xpack/actions/workflows/ci.yml/badge.svg)](https://github.com/micro-os-plus/build-helper-xpack/actions/workflows/ci.yml)

# A source code project with files to help µOS++ builds

This project provides various support files to be included during builds.

The project is hosted on GitHub as
[micro-os-plus/build-helper-xpack](https://github.com/micro-os-plus/build-helper-xpack).

## Maintainer info

This page is addressed to developers who plan to include this source
library into their own projects.

For maintainer info, please see the
[README-MAINTAINER](README-MAINTAINER.md) file.

## Install

This project can be integrated into another project
in the traditional way,
by either copying the relevant files into the target project, or by linking
the entire project as a Git submodule.

However, the workflow can be further automated and the most convenient way is
to **add it as a dependency** to the project via **xpm**.

### Install with xpm/npm

Along with the source files, this project also includes a
`package.json` file with the metadata that allows it to be identified as an
**xpm/npm** package so that it can be directly installed from GitHub or
from the [npmjs.com](https://www.npmjs.com) registry as
[`@micro-os-plus/build-helper`](https://www.npmjs.com/package/@micro-os-plus/build-helper).

#### Prerequisites

A recent [xpm](https://xpack.github.io/xpm/),
which is a portable [Node.js](https://nodejs.org/) command line application
that complements [npm](https://docs.npmjs.com)
with several extra features specific to
**C/C++ projects**.

It is recommended to update to the latest version with:

```sh
npm install --global xpm@latest
```

For details please follow the instructions in the
[xPack install](https://xpack.github.io/install/) page.

Warning: Be sure **xpm** is not installed with administrative rights.

#### xpm

This project can be installed as a package from the
`npmjs.com` registry with:

```sh
cd my-project
xpm init # Unless a package.json is already present

xpm install @micro-os-plus/build-helper@latest

ls -l xpacks/@micro-os-plus/build-helper
```

#### npm

The package can also be installed with [npm](https://docs.npmjs.com)
or related, but
the features specific to C/C++ projects will not be available;
therefore, at least for consistency reasons, it is recommended
to use **xpm**.

### Add as a Git submodule

Besides manually copying the relevant files to the target
project, which will later require extra maintenance efforts to keep the
project up to date, a more convenient
solution is to link the entire project as a **Git submodule**,
for example below an `xpacks` folder:

```sh
cd my-project
git init # Unless already a Git project
mkdir -p xpacks

git submodule add https://github.com/micro-os-plus/build-helper-xpack.git \
  xpacks/@micro-os-plus/build-helper
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

The xPack Build Framework is neutral to the actual system build generator
used.

Currently all µOS++ source libraries support both **CMake** and **meson**,
and an internal xPack builder is planned.

### Build & integration info

TBD

### Known problems

- none

### Examples

TBD

### Toolchains

µOS++ sources should comply with **C++ 20** and **C 11**

- GCC: `-std=c++-20` or `-std=c11`
- clang: `-std=c++-20` or `-std=c11`

It should be possible to compile them with:

- GCC 8 or newer (https://gcc.gnu.org/projects/cxx-status.html)
- LLVM clang 7 or newer (https://clang.llvm.org/cxx_status.html)

The recommended versions are GCC 12, AppleClang 15.

## Change log - incompatible changes

According to [semver](https://semver.org) rules:

> Major version X (X.y.z | X > 0) MUST be incremented if any
backwards incompatible changes are introduced to the public API.

The incompatible changes, in reverse chronological order,
are:

- v2.x: add `xpack_` prefix
- v1.x: initial version

## License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT/),
with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul).
