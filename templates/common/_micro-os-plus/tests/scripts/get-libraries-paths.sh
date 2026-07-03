#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# DO NOT EDIT!
# Automatically generated from build-helper/templates/*.
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

if [ $# -lt 1 ]
then
  echo "Usage: get-libraries-paths.sh clang++|g++ [options...]"
  exit 1
fi

function pyrealpath()
{
  local path=""
  while [ $# -gt 0 ]
  do
    if [ ${1:0:1} == "-" ]
    then
      shift
    else
      path=${1}
      break
    fi
  done
  if [ -z "${path}" ]
  then
    echo "usage: pyrealpath ... path"
    exit 1
  fi

  python -c 'import os, sys; print(os.path.realpath(os.path.abspath(sys.argv[1])))' "${path}"
}

# set -x

if [[ "$(basename $1)" =~ .*clang.* ]]
then
  if [ "$(uname)" == "Linux" ]
  then
    runtime_path="$("$@" -print-runtime-dir)"
    libcpp_path="$("$@" -print-file-name=libc++.so)"
    libs_path="$(dirname $(realpath "${libcpp_path}")):${runtime_path}"
  elif [ "$(uname)" == "Darwin" ]
  then
    cxx_absolute_path="$(pyrealpath "$(which ${1})")"
    lib_absolute_path="$(dirname $(dirname "${cxx_absolute_path}"))/lib"
    libs_path=""
    if [ -d "${lib_absolute_path}" ]
    then
      libcpp_path=$(find "${lib_absolute_path}" -name 'libc++.dylib')
      if [ -n "${libcpp_path}" ]
      then
        libs_path="$(dirname ${libcpp_path}):"
      fi
    fi
    libs_path+="$(dirname $("$@" -print-libgcc-file-name))"
  else
    echo "Unsupported platform"
    exit 1
  fi
elif [[ "$(basename $1)" =~ .*g[c+][c+].* ]]
then
  # On macOS all libraries are in lib.
  # On Linux x64 they are in lib64/lib32
  # On Linux arm64/arm they are in lib.
  libstdcpp_path="$("$@" -print-file-name=libstdc++.a)"
  if [ "$(uname)" == "Linux" ]
  then
    libs_path="$(dirname $(realpath -m "${libstdcpp_path}"))"
  elif [ "$(uname)" == "Darwin" ]
  then
    libs_path="$(dirname $("${pyrealpath}" -m "${libstdcpp_path}"))"
  else
    echo "Unsupported platform"
    exit 1
  fi
else
  libs_path=""
fi

echo -n "${libs_path}"

# -----------------------------------------------------------------------------
