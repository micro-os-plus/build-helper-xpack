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

tmp_file_show_remote="$(mktemp)"
cat <<'__EOF__' >"${tmp_file_show_remote}"
cd "$1/.."
echo $1
git remote -v

__EOF__

tmp_file_show_branch="$(mktemp)"
cat <<'__EOF__' >"${tmp_file_show_branch}"
cd "$1/.."
echo $1
git branch

__EOF__

tmp_file_merge_develop="$(mktemp)"
cat <<'__EOF__' >"${tmp_file_merge_develop}"
cd "$1/.."

echo
echo $1
git switch xpack
git merge xpack-develop
git push
git switch xpack-develop

__EOF__

tmp_file_readme="$(mktemp)"
cat <<'__EOF__' >"${tmp_file_readme}"
cd "$1/.."

echo
echo $1
git add README.md
git commit -m "README updates"

__EOF__

tmp_file_readme_maintainer="$(mktemp)"
cat <<'__EOF__' >"${tmp_file_readme_maintainer}"
cd "$1/.."

echo
echo $1
git add README-MAINTAINER.md
git commit -m "README-MAINTAINER updates"

__EOF__

tmp_file_commit_all="$(mktemp)"
cat <<'__EOF__' >"${tmp_file_commit_all}"
cd "$1/.."

echo
echo $1
git add -A
git commit -m "Update min CMake 3.19"

__EOF__

tmp_file_package_json="$(mktemp)"
cat <<'__EOF__' >"${tmp_file_package_json}"
cd "$1/.."

echo
echo $1
git add package.json
git commit -m "package.json remove git url"

__EOF__

# -----------------------------------------------------------------------------

set -x

# UPDATE ME!
commands_file="${tmp_file_package_json}"

repos_folder="$(dirname $(dirname "${script_folder_path}"))"

cd "${repos_folder}"

find . -type d -name '.git' -print0 | sort -zn | \
  xargs -0 -I '{}' bash "${commands_file}" '{}'

echo

# -----------------------------------------------------------------------------
