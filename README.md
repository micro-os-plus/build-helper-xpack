[![license](https://img.shields.io/github/license/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/blob/xpack/LICENSE)

# A source xPack with files to help builds

This project provides files to be included during builds.

## Maintainer info

This page is addressed to developers who plan to include this package
into their own projects.

For maintainer infos, please see the
[README-MAINTAINER](README-MAINTAINER.md) file.

## Easy install

Note: the package will be available from npmjs.com at a later date.

When ready, this package will be available as
[`@micro-os-plus/build-helper`](https://www.npmjs.com/package/@micro-os-plus/build-helper)
from the `npmjs.com` registry; with [xpm](https://xpack.github.io/xpm/)
available, installing the latest version of the package is quite easy:

```console
$ cd <project>
$ xpm init # Unless a package.json is already present

$ xpm install @micro-os-plus/build-helper@latest
```

This package is also available from
[GitHub](https://github.com/micro-os-plus/build-helper-xpack):

```console
$ git clone https://github.com/micro-os-plus/build-helper-xpack.git build-helper-xpack.git
```

## Branches

Apart from the unused `master` branch, there are three active branches:

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

## Build & integration info

TBD

## Example

TBD

## License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT), with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul).
