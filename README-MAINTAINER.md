[![license](https://img.shields.io/github/license/micro-os-plus/build-helper-xpack)](https://github.com/micro-os-plus/build-helper-xpack/blob/xpack/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/micro-os-plus/build-helper-xpack.svg)](https://github.com/micro-os-plus/build-helper-xpack/issues/)
[![GitHub pulls](https://img.shields.io/github/issues-pr/micro-os-plus/build-helper-xpack.svg)](https://github.com/micro-os-plus/build-helper-xpack/pulls)

# Maintainer info

## Project repository

The project is hosted on GitHub:

- <https://github.com/micro-os-plus/build-helper-xpack.git>

To clone the stable branch (`xpack`), run the following commands in a
terminal (on Windows use the _Git Bash_ console):

```sh
rm -rf ~/Work/micro-os-plus/build-helper-xpack.git && \
mkdir -p ~/Work/micro-os-plus && \
git clone \
  https://github.com/micro-os-plus/build-helper-xpack.git \
  ~/Work/micro-os-plus/build-helper-xpack.git
```

For development purposes, clone the development branch (`xpack-development`):

```sh
rm -rf ~/Work/micro-os-plus/build-helper-xpack.git && \
mkdir -p ~/Work/micro-os-plus && \
git clone \
  --branch xpack-development \
  https://github.com/micro-os-plus/build-helper-xpack.git \
  ~/Work/micro-os-plus/build-helper-xpack.git
```

To link it to the central xPack store:

```sh
xpm link -C ~/Work/micro-os-plus/build-helper-xpack.git
```

## Prerequisites

A recent [xpm](https://xpack.github.io/xpm/), which is a portable
[Node.js](https://nodejs.org/) command line application.

## How to make new releases

### Release schedule

There are no fixed releases.

### Check Git

In the `micro-os-plus/build-helper` Git repo:

- switch to the `xpack-development` branch
- if needed, merge the `xpack` branch

No need to add a tag here, it'll be added when the release is created.

### Increase the version

Update the`package.json` file; add an extra field in the
pre-release field, and initially also add `.pre`,
for example `3.0.0-pre`.

### Fix possible open issues

Check GitHub issues and pull requests:

- <https://github.com/micro-os-plus/build-helper/issues/>

and fix them; assign them to a milestone (like `3.0.0`).

### Update `README-MAINTAINER.md`

Update the following files to reflect the changes
related to the new version:

- `README-MAINTAINER.md`
- `README.md`

### Update `CHANGELOG.md`

- open the `CHANGELOG.md` file
- check if all previous fixed issues are in
- add a new entry like _* v3.0.0_
- commit with a message like _prepare v3.0.0_

### Push changes

- commit and push

### Commit the new version

- select the `xpack-development` branch
- commit all changes
- `npm pack` and check the content of the archive, which should list
  only `package.json`, `README.md`, `LICENSE`, `CHANGELOG.md`,
  the `doxygen-awesome-*.js` and `doxygen-custom/*` files;
  possibly adjust `.npmignore`
- `npm version patch`, `npm version minor`, `npm version major`
- push the `xpack-development` branch to GitHub
- the `postversion` npm script should also update tags via `git push origin --tags`
- wait for the CI job to complete
  (<https://github.com/micro-os-plus/build-helper-xpack/actions/workflows/test-ci.yml>)

## Publish to npmjs.com

- `npm publish --tag next` (use `npm publish --access public` when
  publishing for the first time)

The version is visible at:

- <https://www.npmjs.com/package/@micro-os-plus/build-helper?activeTab=versions>

## Test

Test the package.

## Update the repo

When the package is considered stable:

- with a Git client (VS Code is fine)
- merge `xpack-development` into `xpack`
- push to GitHub
- select `xpack-development`

## Tag the npm package as `latest`

When the release is considered stable, promote it as `latest`:

- `npm dist-tag ls @micro-os-plus/build-helper`
- `npm dist-tag add @micro-os-plus/build-helper@3.0.0 latest`
- `npm dist-tag ls @micro-os-plus/build-helper`

---

## How to add it to a new repo

```sh
mkdir -p tests
xpm init -C tests
```

```sh
npm --prefix tests install del-cli json liquidjs --save-dev
xpm link @micro-os-plus/build-helper -C tests
npm --prefix tests link @xpack/npm-packages-helper)
```

```json
  "scripts": {
    "generate-tests-commons-init": "bash xpacks/@xpack/docusaurus-template-liquid/maintenance-scripts/generate-website-commons.sh --micro-os-plus --init"
  },
```
