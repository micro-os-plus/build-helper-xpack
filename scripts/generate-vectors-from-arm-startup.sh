#!/usr/bin/env bash

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

# Script to enumerate the assembly `arm/startup_*.s` files and convert
# them all to `vector_*.c`.

if [ $# -lt 2 ]
then
  echo "Using: bash $(basename $0) <source-folder> <dest_folder_pathination-folder>"
  exit 1
fi

source_folder_path="$1"
dest_folder_path="$2"

echo
echo "${dest_folder_path}"

# Remove all similar existing files
rm -f "${dest_folder_path}"/vectors_*.c

mkdir -p "${dest_folder_path}"

for f in "${source_folder_path}"/startup_*.s
do
  startup_file_name=$(basename ${f})
  vectors_file_name=$(echo ${startup_file_name} | sed -e 's|startup|vectors|' -e 's|[.]s|.c|')
  echo "${startup_file_name} -> ${vectors_file_name}"
  bash "${script_folder_path}/convert-arm-asm-to-c.sh" "${f}" >"${dest_folder_path}/${vectors_file_name}"
done

# -----------------------------------------------------------------------------
