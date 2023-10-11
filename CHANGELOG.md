# Change & release log

Releases in reverse chronological order.

Please check
[GitHub](https://github.com/micro-os-plus/build-helper-xpack/issues/)
and close existing issues and pull requests.

## 2023-10-11

* v2.14.1
* 10592fd remove -Wmissing-include-dirs on macOS
* 8824f34 2.14.0
* 23076f8 prepare v2.14.0

## 2023-10-10

* a69abb7 README update
* 035a0ae cmake/README update
* b9dc28b add dev-scripts/get-libraries-paths.sh

## 2023-07-22

* e9900f3 README updates

## 2023-07-21

* f063589 README updates
* 1bc3432 README updates

## 2023-07-18

* f3998fe templates/READMEs update

## 2023-07-14

* 2154a1c README updates
* 5e8685c ci.yml: xpm 0.16.2
* 278eb23 README update
* 9df12df README update

## 2023-07-13

* 9b2cbaf rename ci.yml
* d85f76d README update
* 769c1f1 README update
* 7ffa72e CI.yml: update for xpm 0.16.2
* 977ad8d 2.13.0
* 14a30eb CHANGELOG: update for 2.13.0
* 72b1249 package.json: minXpm 0.16.2
* bbbac45 templates: minXpm 0.16.2

## 2023-07-04

* 687597d package.json: 2.13.0-pre.5
* 2147e7e .npmignore remove dev-scripts

## 2023-06-30

* d5c0995 package.json: 2.13.0-pre.4
* 263c274 cross toolchains: explicit commands
* 396838f toolchains: comment out CMAKE_ASM_FLAGS

## 2023-06-23

* d043b15 package.json: 2.13.0-pre.3
* 4d1e8a8 package.json: url cosmetics
* fe550d2 READMEs updates
* f7e1582 templates update
* e3a151c cmake: add xpack_add_cross_custom_commands

## 2023-06-04

* 8fc469b templates/ci.yml: bump deps
* 3000831 package-xpack.json: build-helper-xpack#xpack-develop
* 8e54f38 cmake: update for @scope/name
* 5b83e2c remove --quiet

## 2023-06-03

* e23425f lower case ci.yml
* fd995ad lower case ci.yml
* 26046fc package.json min 0.16.0
* 9e947a0 CI.yml: matrix.xpm-version
* 297121b update xpack multi-level folders

## 2023-05-30

* ba308cd CI.yml: update macos-12

## 2023-05-29

* 6cc7e56 doxygen: update for 1.9.7, add original-config

## 2023-05-28

* 301d9f9 cards.css: stroke-width 1.5
* 3fb0177 cards.css: svg 64px, stroke-width 2
* 71c13c5 cards.css: hide anchor link
* 96f9bea add doxygen/cards.css

## 2023-05-19

* 5dde9a6 bump package.json version pre.1
* 6782491 tests/CMakeLists.txt: comment out VERSION
* 6c6caab add common-header-micro-os-plus.html

## 2023-05-16

* bf34ec5 common-config.doxyfile: comment out IMAGE_PATH

## 2023-05-15

* 45258bd README update
* bfb3125 package.json: 2.13.0-pre
* 6eb76bc add doxygen TIPS & TRICKS
* dd815a1 README update
* 85fe4ee common-config.doxyfile: CREATE_SUBDIRS = NO

## 2023-05-10

* 19c47be add doxygen/README.md
* 14b74fe 2.12.0
* 3e11ba9 prepare v2.12.0
* ad8fcd9 #3: dd common Doxygen files

## 2023-05-08

* v2.12.0
* 5942c7f .npmignore update
* 848d6c6 meson.build cosmetics

## 2022-08-16

* 7218f17 package.json min 0.14.0 & defaults

## 2022-08-04

* b144ffc template/cross.ini: add link to cpu-families

## 2022-08-03

* 28eb572 .vscode/settings.json: cmake.ignoreCMakeListsMissing
* 1de341f .vscode/settings.json: makefile.configureOnOpen
* 6b3bb99 .vscode/settings.json: makefile.configureOnOpen

## 2022-07-28

* v2.11.0
* 8e06902 templates/READMEs updates
* d6b9ed0 templates/package.json: minimumXpmRequired 0.13.7
* 85525e9 templates: no -fno-move-loop-invariants -fno-use-cxa-atexit
* e660fc4 template/.vscode: wordWrap
* 577b2cd template/CI.yml: skip tags
* 5ec9f3c add meta/xpack-root.json
* 7616888 CI.yml do not trigger on tags

## 2022-07-22

* e937587 templates: MICRO_OS_PLUS_INCLUDE_SEMIHOSTING_SYSCALLS

## 2022-07-13

* b5e773b cmake.ignoreCMakeListsMissing

## 2022-07-12

* v2.10.1
* c232754 CMakeLists.txt: fix syntax
* v2.10.0
* ae8be74 templates: bump deps
* 57a07b1 CMake xpack_display_greetings() with arg
* ba6cdbb add xpack_add_dependencies_subdirectories() macro

## 2022-07-09

* v2.9.0
* 1b7c699 #2: Update convert-arm-asm-to-c.sh to use __stack
* 1ec56bd #1: pass optional argv to xpack_display_greetings()

## 2022-06-05

* v2.8.0
* 6dcbeb0 cleanup meson/*-cmd.ini
* 3e3f09e add riscv-none-elf-gcc toolchain

## 2022-06-04

* f9c1a65 update for sections-flash.ld
* 883efe8 meson: update for arm-cmsis-core
* e44ee7e meson: disable -Wc++-compat for assembly

## 2022-05-26

* bfe6d1b add aarch64-none-elf-gcc toolchain

## 2022-04-10

* v2.7.1 published
* move common-tests-source.sh to templates
* v2.7.0 published
* add scripts/common-tests-source.sh
* rename dev-scripts
* templates updates

## 2022-03-27

* v2.6.3
* v2.6.2 published

## 2022-03-23

* v2.6.2 prepared
* templates more cmake/meson consistency
* 865289d clone-and-link update with new xpacks

## 2022-03-21

* 81c9e8d templates/tests-3rd-party updates

## 2022-03-03

* 592b4b3 .clang-format default c++20

## 2022-02-24

* v2.6.1
* 1f6b1f0 update template

## 2022-02-21

* v2.6.0
* 12a4d9c meson: separate platform toolchain files
* bc34d9d gcc.cmake: gcc-ar for windows too
* fcb90ce platform-native: -static-libgcc -static-libstdc++ for GCC
* 87ca9ce move cmake & meson templates
* v2.5.1
* 6f7ddd7 gcc.cmake: CMAKE_AR CMAKE_RANLIB

## 2022-02-20

* 313c888 add templates

## 2022-02-18

* v2.5.0
* 8ce33a4 package.json update actions
* 88d5544 tests/CMakeLists
* fd8361e cmake/helper: display SYSTEM_NAME & PROCESSOR

## 2022-02-11

* v2.4.2
* 1e46852 meson/gcc.ini: remove gcc-ar/ranlib
* v2.4.1
* 97bcb5b meson/templates update

## 2022-02-10

* v2.4.0
* 18da2f9 cmake global add xpack_display_global_lists()
* 526824e cmake & meson add -Wno-poison-system-directories

## 2022-02-05

* v2.3.1
* 0e35cf2 meson/enable-all-warnings: revert to without warning_level

## 2022-02-04

* v2.3.0
* dc5e3e4 scripts/clone: update for device-*
* 17c0fcd meson: add scripts and templates
* 2cc967a move cmake templates to sub-folder
* 9b7666a move toolchains to sub-folder
* cf29ef8 cmake/build-helper cosmetics

## 2022-01-26

* v2.2.0
* rename micro-os-plus-build-helper.cmake module

## 2022-01-02

* v2.1.7
* add meson windows toolchains (.cmd)
* v2.1.6
* v2.1.5
* add meson toolchains

## 2021-12-29

* v2.1.4
* add toolchain-clang.cmake

## 2021-12-27

* v2.1.3
* add toolchain-gcc.cmake

## 2021-03-11

* v2.1.2
* lower min to GCC 7
* remove -Wpedantic
* disable -Wmismatched-tags for GCC 10.1

## 2021-03-10

* v2.1.1
* xpack-helper.cmake: versioned warnings

## 2021-03-09

* v2.1.0
* add xpack_set_all_compiler_warnings()
* add xpack_process_package_version()
* add xpack_glob_recurse_cxx()

## 2021-03-01

* cmake: xpack_append_cmake_prefix_path folder/meta/*-config.cmake
* v2.0.0

## 2021-02-23

* add `xpack_` prefix
* prepare v2.0.0-pre

## 2021-02-06

* prepare v1.2.0
* add parse_semver
* add tests/meta/CMakeLists.txt

## 2021-02-04

* publish v1.1.0 on GitHub
* first restructured release
