[![license](https://img.shields.io/github/license/xpack-3rd-party/xxx-yyy-xpack)](https://github.com/xpack-3rd-party/xxx-yyy-xpack/blob/xpack/LICENSE)
[![CI on Push](https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/workflows/CI.yml/badge.svg)](https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/workflows/CI.yml)
[![GitHub issues](https://img.shields.io/github/issues/xpack-3rd-party/xxx-yyy-xpack.svg)](https://github.com/xpack-3rd-party/xxx-yyy-xpack/issues/)
[![GitHub pulls](https://img.shields.io/github/issues-pr/xpack-3rd-party/xxx-yyy-xpack.svg)](https://github.com/xpack-3rd-party/xxx-yyy-xpack/pulls)

# Maintainer info

## Project repository

The project is hosted on GitHub:

- <https://github.com/xpack-3rd-party/xxx-yyy-xpack.git>

To clone the stable branch (`xpack`), run the following commands in a
terminal (on Windows use the _Git Bash_ console):

```sh
rm -rf ~/Work/xxx-yyy-xpack.git && \
mkdir -p ~/Work && \
git clone \
  https://github.com/xpack-3rd-party/xxx-yyy-xpack.git \
  ~/Work/xxx-yyy-xpack.git
```

For development purposes, clone the `xpack-develop` branch:

```sh
rm -rf ~/Work/xxx-yyy-xpack.git && \
mkdir -p ~/Work && \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-3rd-party/xxx-yyy-xpack.git \
  ~/Work/xxx-yyy-xpack.git
```

## Prerequisites

A recent [xpm](https://xpack.github.io/xpm/), which is a portable
[Node.js](https://nodejs.org/) command line application.

## Code formatting

Code formatting is done using `clang-format --style=file`, either manually
from a script, or automatically from Visual Studio Code, or the Eclipse
CppStyle plug-in.

Always reformat the source files that were changed.

## Development info

### Install dependencies

With a clean slate, install dependencies:

```sh
cd ~/Work/xxx-yyy-xpack.git

xpm run install-all
```

This will install the project wide dependencies and all the build
configuration dependencies, so at the first run it may take a while.

## Run tests manually

The project includes unit tests.

To perform the tests, run the usual xpm sequence:

```sh
cd ~/Work/micro-test-plus-xpack.git

xpm run test-all
```

### Clone writeable dependencies

The above procedure will allow to develop the project itself, but the
dependencies will be read-only; to be able to contribute to them,
also clone the `xpack-develop` branches of the source xPacks dependencies
into a folder of your choice and add links from the central xPacks
storage to them by running `xpack link` in each folder.

To automate this, there is a helper script to clone these repos into
`${HOME}/Work/micro-os-plus-xpack-repos`:

```sh
curl -L https://raw.githubusercontent.com/micro-os-plus/build-helper-xpack/xpack/scripts/clone-and-link-all-git-repos.sh | bash -
```

Note: If you prefer a different location, start the script with
the absolute path of destination folder as the first argument.

After cloning all Git repos, add links from this project to the development
packages, by running the `link-deps` action:

```sh
cd micro-test-plus-xpack.git

xpm run link-deps
```

Similarly for each build configuration that requires the development packages;
for example:

```sh
cd micro-test-plus-xpack.git

xpm run link-deps --config native-cmake-debug
```

## How to make new releases

### Release schedule

There are no fixed releases, they generally follow the upstream releases.

### Check Git

In the `xpack-3rd-party/xxx-yyy-xpack` Git repo:

- switch to the `xpack-develop` branch
- if needed, merge the `xpack` branch

No need to add a tag here, it'll be added when the release is created.

### Check and merge the latest upstream release

TODO

### Increase the version

Determine the upstream version (like `0.1.0`) and eventually update the
`package.json` file; the format is `0.1.0-1-pre`. The fourth number is the xPack release number
of this version.

### Fix possible open issues

Check GitHub issues and pull requests:

- <https://github.com/xpack-3rd-party/xxx-yyy-xpack/issues/>

and fix them; assign them to a milestone (like `0.1.0-1`).

### Update `README.md`

Update the `README.md` file to reflect the changes related to the new version.

### Update version in `README-3RD-PARTY.md`

Update the few references to the new version.

### Update `CHANGELOG.md`

- open the `CHANGELOG.md` file
- check if all previous fixed issues are in
- add a new entry like _* v0.1.0-1_
- commit with a message like _prepare v0.1.0-1_

### Push changes

- reformat the source files that were changed
- commit and push

## Tests

### Continuous Integration

The project is fully tested via GitHub
[Actions](https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/);
the **CI** job is automatically triggered on **Push**;
it runs a selection of the tests on GitHub hosted runners,
and the results are available at
[CI on Push](https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/workflows/CI.yml).

## Publish on the npmjs.com server

- select the `xpack-develop` branch
- commit all changes
- update versions in `README-MAINTAINER-XPACK.md`
- update `CHANGELOG-XPACK.md`
- commit with a message like _prepare v0.1.0-1_
- `npm pack` and check the content of the archive, which should list
  only `package.json`, `README.md`, `LICENSE`, `CHANGELOG-XPACK.md`,
  the sources and CMake/meson files;
  possibly adjust `.npmignore`
- `npm version v0.1.0-1`
- push the `xpack-develop` branch to GitHub
- the `postversion` npm script should also update tags via `git push origin --tags`
- wait for the CI job to complete
  (<https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/workflows/CI.yml>)

### Test on all platforms

In addition, it is possible to manually trigger a **test-all** job, that
runs all available builds, on all supported platforms, including Linux Arm
and macOS Apple Silicon.

For this:

- start the `~/actions-runners/micro-os-plus/run.sh &` runner on `xbbma` and `xbbla`
- ensure that the `xpack-develop` branch is pushed
- run the `trigger-workflow-test-all` action
- wait for the **test-all** job to complete
  (<https://github.com/xpack-3rd-party/xxx-yyy-xpack/actions/workflows/test-all.yml>)

### Publish

- `npm publish --tag next` (use `npm publish --access public` when
  publishing for the first time)

The version is visible at:

- <https://www.npmjs.com/package/@xpack-3rd-party/xxx-yyy?activeTab=versions>

## Update the repo

When the package is considered stable:

- with a Git client (VS Code is fine)
- merge `xpack-develop` into `xpack`
- push to GitHub
- select `xpack-develop`

## Test

Use the source library xPack as dependency in other projects and check
if it performs as expected.

## Tag the npm package as `latest`

When the release is considered stable, promote it as `latest`:

- `npm dist-tag ls @xpack-3rd-party/xxx-yyy`
- `npm dist-tag add @xpack-3rd-party/xxx-yyy@0.1.0-1 latest`
- `npm dist-tag ls @xpack-3rd-party/xxx-yyy`

## Share on Twitter

- in a separate browser windows, open [TweetDeck](https://tweetdeck.twitter.com/)
- using the `@micro_os_plus` account
- paste the release name like **µOS++ XXX YYY v0.1.0-1 released**
- paste the link to the GitHub release
- click the **Tweet** button
