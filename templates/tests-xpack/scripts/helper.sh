# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2022 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Common functions used in various tests.
# -----------------------------------------------------------------------------

function run_verbose()
{
  # Does not include the .exe extension.
  local app_path=$1
  shift

  echo
  echo "[${app_path} $@]"
  "${app_path}" "$@" 2>&1
}

function trigger_github_workflow()
{
  local github_org="$1"
  local github_repo="$2"
  local workflow_id="$3"
  local data_file_path="$4"
  local token="$5"

  echo
  echo "Request body:"
  cat "${data_file_path}"

  # This script requires an authentication token in the environment.
  # https://docs.github.com/en/rest/reference/actions#create-a-workflow-dispatch-event

  echo
  echo "Response:"

  curl \
    --request POST \
    --include \
    --header "Authorization: token ${token}" \
    --header "Content-Type: application/json" \
    --header "Accept: application/vnd.github.v3+json" \
    --data-binary @"${data_file_path}" \
    https://api.github.com/repos/${github_org}/${github_repo}/actions/workflows/${workflow_id}/dispatches

  rm -rf "${data_file_path}"
}

# -----------------------------------------------------------------------------

# Install npm on fresh docker images.
function update_image()
{
  local image_name="$1"
  echo "update_image ${image_name}"

  # Make sure that the minimum prerequisites are met.
  if [[ ${image_name} == github-actions-image ]]
  then
    : # Undefined image, like for self-hosted.
  elif [[ ${image_name} == github-actions-ubuntu* ]]
  then
    : # sudo apt-get -qq install -y XXX
  elif [[ ${image_name} == *node:lts ]]
  then
    run_verbose apt-get -qq update
    run_verbose apt-get -qq install -y lsb-release
  elif [[ ${image_name} == *ubuntu* ]] || [[ ${image_name} == *debian* ]] || [[ ${image_name} == *raspbian* ]]
  then
    run_verbose apt-get -qq update
    run_verbose apt-get -qq install -y curl g++ lsb-release
    # run_verbose apt-get -qq install -y libc6-dev libstdc++6
  elif [[ ${image_name} == *centos* ]] || [[ ${image_name} == *redhat* ]] || [[ ${image_name} == *fedora* ]]
  then
    run_verbose yum install -y -q curl g++ redhat-lsb-core
    # run_verbose yum install -y -q glibc-devel glibc-static libstdc++-devel
  elif [[ ${image_name} == *suse* ]]
  then
    run_verbose zypper -q in -y curl g++ lsb-release
    # run_verbose zypper -q in -y glibc-devel glibc-devel-static libstdc++6
  elif [[ ${image_name} == *manjaro* ]]
  then
    # run_verbose pacman-mirrors -g
    run_verbose pacman -S -y -q --noconfirm

    # Update even if up to date (-yy) & upgrade (-u).
    # pacman -S -yy -u -q --noconfirm
    run_verbose pacman -S -q --noconfirm --noprogressbar curl g++ lsb-release
    # run_verbose pacman -S -q --noconfirm --noprogressbar gcc-libs
  elif [[ ${image_name} == *archlinux* ]]
  then
    run_verbose pacman -S -y -q --noconfirm

    # Update even if up to date (-yy) & upgrade (-u).
    # pacman -S -yy -u -q --noconfirm
    run_verbose pacman -S -q --noconfirm --noprogressbar curl g++ lsb-release
    # run_verbose pacman -S -q --noconfirm --noprogressbar gcc-libs
  else
    echo "Nothing to be installed..."
  fi

  echo
  echo "The system C/C++ libraries..."
  find /usr/lib* /lib -name 'libc.*' -o -name 'libstdc++.*' -o -name 'libgcc_s.*'
}
