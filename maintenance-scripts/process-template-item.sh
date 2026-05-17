#!/usr/bin/env bash

# -----------------------------------------------------------------------------
#
# This file is part of the µOS++ project (http://micro-os-plus.github.io).
# Copyright (c) 2024-2026 Liviu Ionescu.  All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can be
# obtained from https://opensource.org/licenses/mit.
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

# The script is invoked from xpacks/@micro-os-plus/build-helper/maintenance-scripts/generate-commons.sh.

npm_helper_folder_path="$(dirname $(dirname $(dirname $(dirname "${script_folder_path}"))))/node_modules/@xpack/npm-packages-helper"

source "${npm_helper_folder_path}/maintenance-scripts/scripts-helper-source.sh"

# -----------------------------------------------------------------------------

# Runs in the source folder.
# $1 = relative file path to source, starts with `./`
# $2 = absolute folder path to destination

# echo "argv: $@"
# echo "pwd: $(pwd)"
# set -x

do_force="false"
do_remove="false"

while [[ "${1}" == --* ]]
do
  case "${1}" in
    --force)
      # Ask to override and write protect.
      do_force="true"
      ;;

    --remove)
      # Ask to remove.
      do_remove="true"
      ;;

    *)
      echo "Unrecognised option '${1}'"
      exit 1
      ;;
  esac
  shift
done

export do_force
export do_remove

# -----------------------------------------------------------------------------

# If one of the selector paths is present, but not the right one, exit.
if check_if_should_ignore_path "$@"
then
  exit 0
fi

prepare_paths "$@"

# -----------------------------------------------------------------------------

tmp_file_path="$(mktemp -t top_commons.XXXXX)"

# Used to enforce an exit code of 255, required by xargs.
trap 'trap_handler ${from_relative_file_path} $LINENO $? ${tmp_file_path}; return 255' ERR

# -----------------------------------------------------------------------------

# Superfluous, `find -type f` should not allow this.
if [ ! -f "${from_relative_file_path}" ]
then
  echo "${from_relative_file_path} not a file"
  exit 1
fi

if [ "$(basename "${from_relative_file_path}")" == ".DS_Store" ]
then
  echo "${from_relative_file_path} ignored" # Skip macOS specifics.
  exit 0
fi

if [ "${do_remove}" == "true" ]
then
  if [ -f "${to_absolute_file_path}" ]
  then  
    echo "removing: ${to_relative_file_path}"
    rm -f "${to_absolute_file_path}"
  fi
  exit 0
fi

if [ -f "${to_absolute_file_path}" ] && [ "${do_force}" != "true" ]
then
  echo "already present: ${to_relative_file_path}"
  exit 0
fi

# -----------------------------------------------------------------------------
# Compute exclusions.

# Destination relative file paths to skip.
skip_pages_array=("BEGIN")

if [ "${is_micro_os_plus}" == "true" ]
then
  : # if needed
fi

# -----------------------------------------------------------------------------

skip_pages_array+=("END")

# The array members are concatenated with spaces separators.
# echo "skip_pages_array=${skip_pages_array[@]}"
# echo "to_relative_file_path=${to_relative_file_path}"

set +o nounset # Do not exit if variable not set (empty skip_pages_array).

# To ensure proper match, use explicit spaces.
if [[ ${skip_pages_array[@]} =~ " ${to_relative_file_path} " ]]
then
  # echo "skipped: ${from_relative_file_path}"
  echo "skipped: ${to_relative_file_path}"
  rm -f "${tmp_file_path}"
  exit 0
fi

set -o nounset # Exit if variable not set.

# -----------------------------------------------------------------------------

process_file

rm -rf "${tmp_file_path}"

# Completed successfully.
exit 0

# -----------------------------------------------------------------------------
