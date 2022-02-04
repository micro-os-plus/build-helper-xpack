# Change & release log

Releases in reverse chronological order.

Please check
[GitHub](https://github.com/micro-os-plus/build-helper-xpack/issues/)
and close existing issues and pull requests.

## 2022-02-01

- dc5e3e4 scripts/clone: update for device-*
- 17c0fcd meson: add scripts and templates
- 2cc967a move cmake templates to sub-folder
- 9b7666a move toolchains to sub-folder
- cf29ef8 cmake/build-helper cosmetics

## 2022-01-26

- v2.2.0
- rename micro-os-plus-build-helper.cmake module

## 2022-01-02

- v2.1.7
- add meson windows toolcahins (.cmd)
- v2.1.6
- v2.1.5
- add meson toolchains

## 2021-12-29

- v2.1.4
- add toolchain-clang.cmake

## 2021-12-27

- v2.1.3
- add toolchain-gcc.cmake

## 2021-03-11

- v2.1.2
- lower min to GCC 7
- remove -Wpedantic
- disable -Wmismatched-tags for GCC 10.1

## 2021-03-10

- v2.1.1
- xpack-helper.cmake: versioned warnings

## 2021-03-09

- v2.1.0
- add xpack_set_all_compiler_warnings()
- add xpack_process_package_version()
- add xpack_glob_recurse_cxx()

## 2021-03-01

- cmake: xpack_append_cmake_prefix_path folder/meta/*-config.cmake
- v2.0.0

## 2021-02-23

- add `xpack_` prefix
- prepare v2.0.0-pre

## 2021-02-06

- prepare v1.2.0
- add parse_semver
- add tests/meta/CMakeLists.txt

## 2021-02-04

- publish v1.1.0 on GitHub
- first restructured release
