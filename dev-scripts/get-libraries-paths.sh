#!/usr/bin/env bash

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

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
