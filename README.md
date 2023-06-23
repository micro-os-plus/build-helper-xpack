[![license](https://img.shields.io/github/license/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/blob/xpack/LICENSE)

# A source library xPack with files to help µOS++ builds

This project provides files to be included during builds.

The project is hosted on GitHub as
[micro-os-plus/build-helper-xpack](https://github.com/micro-os-plus/build-helper-xpack).

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

Note: the package will be available from npmjs.com at a later date.

For now, it can be installed from GitHub:

```sh
cd my-project
xpm init # Unless a package.json is already present

xpm install github:micro-os-plus/build-helper-xpack
```

When ready, this package will be available as
[`@micro-os-plus/build-helper`](https://www.npmjs.com/package/@micro-os-plus/build-helper)
from the `npmjs.com` registry:

```sh
cd my-project
xpm init # Unless a package.json is already present

xpm install @micro-os-plus/build-helper@latest

ls -l xpacks/@micro-os-plus/build-helper
```

### Git submodule

If, for any reason, **xpm** is not available, the next recommended
solution is to link it as a Git submodule below an `xpacks` folder.

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

The recommended versions are GCC 11, AppleClang 12.

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
