#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2022 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Identify the script location, to reach, for example, the helper scripts.

script_path="$0"
if [[ "${script_path}" != /* ]]
then
  # Make relative path absolute.
  script_path="$(pwd)/$0"
fi

script_name="$(basename "${script_path}")"

script_folder_path="$(dirname "${script_path}")"
script_folder_name="$(basename "${script_folder_path}")"

# =============================================================================

source "${script_folder_path}/helper.sh"

# -----------------------------------------------------------------------------

image_name=""

while [ $# -gt 0 ]
do
  case "$1" in

    --image)
      image_name="$2"
      shift 2
      ;;

    --*)
      echo "Unsupported option $1."
      exit 1
      ;;

    *)
      echo "Unsupported arg $1."
      exit 1
      ;;

  esac
done

# -----------------------------------------------------------------------------

if [ -f "/.dockerenv" ]
then
  if [ -n "${image_name}" ]
  then
    # When running in a Docker container, update it.
    update_image "${image_name}"
  else
    echo "No image defined, quit."
    exit 1
  fi

  if [ -z "$(which npm)" ]
  then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm install --lts node
    nvm use node
    nvm install-latest-npm
  fi
else
  # Not inside a Docker; perhaps a GitHub Actions VM.
  if [ "${GITHUB_ACTIONS:-""}" == "true" -a "${RUNNER_OS:-""}" == "Linux" ]
  then
    # Currently "ubuntu20".
    update_image "github-actions-${ImageOS:-image}"
  fi
fi

# -----------------------------------------------------------------------------

# npm --version
npm install -g xpm@latest

# export PYTHONIOENCODING=utf-8
export LC_CTYPE=C.UTF-8

if [ -f "/.dockerenv" ]
then
  # For self-hosted runners.
  trap "xpm run deep-clean" EXIT
fi

if [ "$(uname)" == "Linux"]
then
  trap "lsb_release -a" EXIT
fi

# Be sure the build starts with a clean slate, since on self-hosted
# runners the build folders are presistent.
xpm run deep-clean

xpm run install-all
xpm run test-all

# -----------------------------------------------------------------------------
