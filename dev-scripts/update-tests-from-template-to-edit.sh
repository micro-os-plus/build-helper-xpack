
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

from_templates="$(dirname ${script_folder_path})/templates/tests"

# Must be called in the tests folder.
cp -v "${from_templates}/CMakeLists.txt" "."
cp -v "${from_templates}/meson.build" "."

for platform in native qemu-cortex-a15 qemu-cortex-a72 qemu-cortex-m0 qemu-cortex-m3 qemu-cortex-m4f qemu-cortex-m7f qemu-riscv-rv32imac qemu-riscv-rv64imafdc
do
    cp -pv "${from_templates}/platforms/${platform}/cmake/dependencies-folders.cmake" "platforms/${platform}/cmake"

    cp -v "${from_templates}/platforms/${platform}/meson/dependencies-folders/meson.build" "platforms/${platform}/meson/dependencies-folders"
done
