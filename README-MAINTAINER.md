[![license](https://img.shields.io/github/license/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/blob/xpack/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/micro-os-plus/build-helper-xpack.svg)](https://github.com/micro-os-plus/build-helper-xpack/issues/)
[![GitHub pulls](https://img.shields.io/github/issues-pr/micro-os-plus/build-helper-xpack.svg)](https://github.com/micro-os-plus/build-helper-xpack/pulls)

# Maintainer info

## Project repository

The project is hosted on GitHub:

- <https://github.com/micro-os-plus/build-helper-xpack.git>

To clone it:

```sh
git clone \
  https://github.com/micro-os-plus/build-helper-xpack.git \
  build-helper-xpack.git
```

For development purposes, clone the `xpack-develop` branch:

```sh
git clone \
  --branch xpack-develop \
  https://github.com/micro-os-plus/build-helper-xpack.git \
  build-helper-xpack.git
```

## Prerequisites

A recent [xpm](https://xpack.github.io/xpm/), which is a portable
[Node.js](https://nodejs.org/) command line application.

## Publish to npmjs.com

- select the `xpack-develop` branch
- commit all changes
- update versions in `README.md` and `README-MAINTAINER.md`
- update `CHANGELOG.md`
- commit with a message like _prepare v2.1.5_
- `npm pack` and check the content of the archive, which should list
  only the `package.json`, the `README.md`, `LICENSE` and `CHANGELOG.md`;
  possibly adjust `.npmignore`
- `npm version patch`, `npm version minor`, `npm version major`
- push the `xpack-develop` branch to GitHub
- push tag to GitHub, with `git push origin --tags`
- `npm publish --tag next` (use `--access public` when publishing for
  the first time)

The version is visible at:

- <https://www.npmjs.com/package/@micro-os-plus/build-helper?activeTab=versions>

## Test

Test the package.

## Update the repo

When the package is considered stable:

- with Sourcetree
- merge `xpack-develop` into `xpack`
- push to GitHub
- select `xpack-develop`

## Tag the npm package as `latest`

When the release is considered stable, promote it as `latest`:

- `npm dist-tag ls @micro-os-plus/build-helper`
- `npm dist-tag add @micro-os-plus/build-helper@2.1.5 latest`
- `npm dist-tag ls @@micro-os-plus/build-helper`

## Announce to the community

Post an announcement to the forum or on Twitter.
