
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
mkdir -pv "cmake"
cp -v "${from_templates}/cmake/common-options.cmake" "cmake"
cp -v "${from_templates}/cmake/tests-main.cmake" "cmake"

mkdir -pv "meson/common-options"
cp -v "${from_templates}/meson/common-options/meson.build" "meson/common-options"
cp -v "${from_templates}/meson_options.txt" "."

mkdir -pv "platforms/native/cmake"
cp -pv "${from_templates}/platforms/native/cmake/platform-options.cmake" "platforms/native/cmake"
mkdir -pv "platforms/native/meson/platform-options"
cp -v "${from_templates}/platforms/native/meson/platform-options/meson.build" "platforms/native/meson/platform-options"
cp -v "${from_templates}/platforms/native/meson/native.ini" "platforms/native/meson"
cp -v "${from_templates}/platforms/native/README.md" "platforms/native"
mkdir -pv "platforms/native/include/micro-os-plus/platform"
cp -v "${from_templates}/platforms/native/include/micro-os-plus/platform/config.h" "platforms/native/include/micro-os-plus/platform"
cp -v "${from_templates}/platforms/native/include/micro-os-plus/platform.h" "platforms/native/include/micro-os-plus"

for platform in qemu-cortex-a15 qemu-cortex-a72 qemu-cortex-m0 qemu-cortex-m3 qemu-cortex-m4f qemu-cortex-m7f qemu-riscv-rv32imac qemu-riscv-rv64imafdc
do
    mkdir -pv "platforms/${platform}/cmake"
    cp -pv "${from_templates}/platforms/${platform}/cmake/platform-options.cmake" "platforms/${platform}/cmake"

    mkdir -pv "platforms/${platform}/meson/platform-options"
    cp -v "${from_templates}/platforms/${platform}/meson/platform-options/meson.build" "platforms/${platform}/meson/platform-options"
    cp -v "${from_templates}/platforms/${platform}/meson/cross.ini" "platforms/${platform}/meson"
    cp -v "${from_templates}/platforms/${platform}/README.md" "platforms/${platform}"

    mkdir -pv "platforms/${platform}/include/micro-os-plus/platform"
    cp -v "${from_templates}/platforms/${platform}/include/micro-os-plus/platform/config.h" "platforms/${platform}/include/micro-os-plus/platform"
    cp -v "${from_templates}/platforms/${platform}/include/micro-os-plus/platform.h" "platforms/${platform}/include/micro-os-plus"
done
