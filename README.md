[![license](https://img.shields.io/github/license/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/blob/xpack/LICENSE)

# A source xPack with files to help µOS++ builds

This project provides files to be included during builds.

The project is hosted on GitHub as
[micro-os-plus/build-helper-xpack](https://github.com/micro-os-plus/build-helper-xpack).

## Maintainer info

This page is addressed to developers who plan to include this package
into their own projects.

For maintainer infos, please see the
[README-MAINTAINER](README-MAINTAINER.md) file.

## Install

As a source xPacks, the easiest way to add it to a project is via **xpm**,
but it can also be used as any Git project, for example as a submodule.

### Prerequisites

A recent [xpm](https://xpack.github.io/xpm/),
which is a portable [Node.js](https://nodejs.org/) command line application.

For details please follow the instructions in the
[install](https://xpack.github.io/install/) page.

### xpm

Note: the package will be available from npmjs.com at a later date.

For now, it can be installed from GitHub:

```console
$ cd <project>
$ xpm init # Unless a package.json is already present

$ xpm install github:micro-os-plus/build-helper-xpack
```

When ready, this package will be available as
[`@micro-os-plus/build-helper`](https://www.npmjs.com/package/@micro-os-plus/build-helper)
from the `npmjs.com` registry:

```console
$ cd <project>
$ xpm init # Unless a package.json is already present

$ xpm install @micro-os-plus/build-helper@latest
```

### Git submodule

If, for any reason, **xpm** is not available, the next recommended
solution is to link it as a Git submodule below an `xpacks` folder.

```console
$ cd <project>
$ git init # Unless already a Git project
$ mkdir -p xpacks

$ git submodule add https://github.com/micro-os-plus/build-helper-xpack.git \
  xpacks/micro-os-plus-build-helper
```

## Branches

Apart from the unused `master` branch, there are two active branches:

- `xpack`, with the latest stable version
- `xpack-develop`, with the current development version

All development is done in the `xpack-develop` branch, and contributions via
Pull Requests should be directed to this branch.

When new releases are published, the `xpack-develop` branch is merged
into `xpack`.

## User info

The current plan for µOS++ is to use the future xPack build tools,
but for now the builds will use **CMake**, and initially this project
will include CMake scripts, mainly used to build the tests, but the
same scripts should also help integrating source xPacks in application
builds.

In a second step it is planned to add support for **meson**.

### Build & integration info

TBD

### Known problems

- none

### Examples

TBD

## License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT/),
with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul/).
