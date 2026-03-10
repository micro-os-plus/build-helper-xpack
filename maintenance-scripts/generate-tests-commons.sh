#!/usr/bin/env bash

# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ project (http://micro-os-plus.github.io).
# Copyright (c) 2024-2026 Liviu Ionescu.  All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/mit.
#
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

export script_path
export script_name="$(basename "${script_path}")"

export script_folder_path="$(dirname "${script_path}")"
export script_folder_name="$(basename "${script_folder_path}")"

# =============================================================================

# set -x

argv="$@"

# Runs as
# .../xpacks/@micros-os-plus/build-helper/maintenance-scripts/generate-commons.sh
npm_helper_folder_path="$(dirname $(dirname $(dirname $(dirname "${script_folder_path}"))))/node_modules/@xpack/npm-packages-helper"

source "${npm_helper_folder_path}/maintenance-scripts/scripts-helper-source.sh"

# Parse --init, --dry-run, --xpack, --xpack-dev-tools
# and leave variables in the environment.
parse_options "$@"

# -----------------------------------------------------------------------------

# Used to enforce an exit code of 255, required by xargs.
trap 'trap_handler "${script_name}" $LINENO $?; return 255' ERR

# -----------------------------------------------------------------------------

if [ "${is_micro_os_plus}" != "true" ]
then
  echo "Unsupported configuration..."
  exit 1
fi

current_folder_path="$(dirname $(dirname $(dirname $(dirname "${script_folder_path}"))))"
project_folder_path="$(dirname "${current_folder_path}")"
tests_folder_path="${project_folder_path}/tests"
templates_folder_path="$(dirname "${script_folder_path}")/templates"

export current_folder_path
export project_folder_path
export templates_folder_path
export tests_folder_path

# -----------------------------------------------------------------------------

if [ "${is_micro_os_plus}" != "true" ]
then
  echo "Unsupported configuration..."
  exit 1
fi

# Process package.json files and leave results in environment variables.
compute_context

# -----------------------------------------------------------------------------

if [ "${do_dry_run}" == "true" ]
then
  echo
  echo "Dry run!"
  echo
fi

# -----------------------------------------------------------------------------

if [ "${do_init}" == "true" ]
then
  cd "${templates_folder_path}/common/_micro-os-plus/tests"
  substitute "package-merge-liquid.json" "package.json" "${project_folder_path}/tests"
  exit 0
else

  if false
  then
    (
      echo
      echo "Relocating files..."

      cd "${project_folder_path}/tests"

      chmod -R +w *

      # relocate "..." "..."

      find . -name '*.bak' -exec rm -v '{}' ';'
    )
  fi

  echo
  echo "Processing template from ${templates_folder_path}..."

  cd "${templates_folder_path}/common"

  # Main pass to copy/generate common files.
  find . -type f -print0 | sort -zn | \
    xargs -0 -I '{}' bash "${script_folder_path}/process-template-item.sh" --force '{}' "${project_folder_path}"

  echo
  echo "First time proposals..."

  cd "${templates_folder_path}/first-time"

  find . -type f -print0 | sort -zn | \
    xargs -0 -I '{}' bash "${script_folder_path}/process-template-item.sh" '{}' "${project_folder_path}"

fi

# -----------------------------------------------------------------------------

echo
echo "'${script_name} ${argv}' done"

# Completed successfully.
exit 0

# -----------------------------------------------------------------------------
