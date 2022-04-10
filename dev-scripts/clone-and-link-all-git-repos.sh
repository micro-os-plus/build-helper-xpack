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

# Clone a repo and checkout the development branch, possibly a given commit.
function clone()
{
  local repo_name="$1"
  local branch_name="$2"

  if [ -d "${repo_name}.git" ]
  then
    echo "${repo_name}.git already present, skiped..."
  else
    git clone --branch "${branch_name}" https://github.com/micro-os-plus/${repo_name}.git ${repo_name}.git
  fi
}

function clone-and-link()
{
  local repo_name="$1"

  echo
  clone "${repo_name}" "xpack-develop"

  # Link it to the central xPacks repo.
  xpm link -C ${repo_name}.git
}

# -----------------------------------------------------------------------------

# "$1" is an optional destination folder path.
# The default is `${HOME}/Work/micro-os-plus-xpack-repos`.

(
  if [ $# -ge 1 ]
  then
    dest="$1"
  else
    dest="${HOME}/Work/micro-os-plus-xpack-repos"
  fi
  mkdir -p "${dest}"
  cd "${dest}"

  clone-and-link "architecture-cortexm-xpack"
  clone-and-link "architecture-riscv-xpack"
  clone-and-link "architecture-synthetic-posix-xpack"
  clone-and-link "build-helper-xpack"
  clone-and-link "cmsis-os-xpack"
  clone-and-link "devices-cortexm-xpack"
  clone-and-link "devices-qemu-cortexm-xpack"
  clone-and-link "devices-sifive-xpack"
  clone-and-link "devices-stm32f0-extras-xpack"
  clone-and-link "devices-stm32f4-extras-xpack"
  clone-and-link "diag-trace-xpack"
  clone-and-link "libs-c-xpack"
  clone-and-link "libs-cpp-estd-xpack"
  clone-and-link "libs-cpp-xpack"
  clone-and-link "memory-allocators-xpack"
  clone-and-link "micro-test-plus-xpack"
  clone-and-link "platform-sifive-arty-xpack"
  clone-and-link "platform-sifive-hifive1-xpack"
  clone-and-link "platform-stm32f4discovery-xpack"
  clone-and-link "posix-io-xpack"
  clone-and-link "rtos-cortexm-xpack"
  clone-and-link "rtos-synthetic-posix-xpack"
  clone-and-link "rtos-xpack"
  clone-and-link "semihosting-xpack"
  clone-and-link "startup-xpack"
  clone-and-link "utils-lists-xpack"
  clone-and-link "version-xpack"
)

echo
echo "Done."

# -----------------------------------------------------------------------------
