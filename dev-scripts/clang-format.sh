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

repos_folder="$(dirname $(dirname "${script_folder_path}"))"

cd "${repos_folder}"

# Add the local bin folder
PATH=${HOME}/.local/bin/clang-format:$PATH

echo "[*.h *.c *.cpp]"
files=$(find . -type f \( -name '*.h' -o -name '*.c' -o -name '*.cpp' \) -not -path '*/stm32cubemx/*' -not -path '*/build/*' -not -path '*/build-*/*')
for f in $files
do
  (
    name="$(basename "$f")"
    echo "$f"
    cd "$(dirname "$f")"
    clang-format --style="file" -i "${name}"
  )
done

echo
echo "[Dotless files]"

files=$(find . -type f -iname '*' -not -iname "*.*" -not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/LICENSE*')
for f in $files
do
  (
    echo "$f"
    cd "$(dirname "$f")"
    clang-format --style="file" -assume-filename="Cpp" -i "$(basename "$f")"
  )
done
