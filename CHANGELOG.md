# Change & release log

Releases in reverse chronological order.

Please check
[GitHub](https://github.com/micro-os-plus/build-helper-xpack/issues/)
and close existing issues and pull requests.

## 2026-08-07

* v4.0.0
* af402b5 templates check get-libraries-paths.mjs result
* 8c306b9 package-merge-liquid.json bump diag-trace version
* a8545bf test-ci: fail-fast false

## 2026-08-06

* 44a411f package-merge-liquid.json bump micro-test-plus
* d3855c3 convert get-libraries-paths-liquid.mjs
* 53e3bf3 native cmake updates

## 2026-08-05

* 940e8a5 README updates
* 979718e cmake & meson updates for other platforms
* 2020294 module-rtos.doxygen update #if defined()
* d370869 convert-arm*.sh update #if defined()
* bfc21a0 package-merge-liquid.json bump deps
* cc7a6c5 README update

## 2026-08-04

* 564c272 README-WARNINGS updates
* 8205d23 package.json add templates
* 875d026 prepare v4.0.0
* 83dca5a convert to xcdl-export-liquid.mjs

## 2026-08-03

* 3102d15 convert generate-tests-commons.mjs
* 1032b15 platform-library-liquid.cmake add -fsanitize to native
* 833ce10 comment out doxygen DOT_MULTI_TARGETS

## 2026-07-28

* becc293 process {{fromFilePath}}
* 51ff57d process useObjectsLibrary

## 2026-07-25

* c8c29c0 update Automatically generated notice
* 5827755 partials: update DO NOT EDIT notice
* 5ea79ad templates: update partials
* a21ffb1 templates: move most headers to partials
* 6126bee rework platform meson.build & move to common
* 3c9640c update templates startup-defines.h

## 2026-07-24

* baa340d move platform CMakeLists-liquid.txt to common DO NOT EDIT
* 0b0cae6 re-work template CMakeLists-liquid.txt
* 0ae2d23 generate-tests-commons: add partials_folder_path
* 3dad652 templates MICRO_OS_PLUS_DIAG_TRACE_ENABLED
* c5829dc templates trace-defines-liquid.h

## 2026-07-23

* 3d6bd72 templates cosmetise .h files
* 21a0758 xpack-root.json
* f5457f7 templates updates for xcdl
* f08a07e fix copyright notices

## 2026-07-19

* 20bb869 template first-time cleanups
* e200c66 package-merge-liquid update for buildVerbose

## 2026-07-16

* 5335862 templates/native update reference

## 2026-07-15

* 0fd46a1 package-merge-liquid.json bump deps
* 0f33d2f tmplates micro-os-plus updates

## 2026-07-03

* fc5cc68 templates update for diag-trace
* 8022db3 add DO NOT EDIT
* c56d3f3 add -stdlib=libc++ to cpp in meson
* 8a6450e fix project url to github.io

## 2026-07-02

* 783a895 package-merge-liquid.json cosmetics

## 2026-07-01

* b1e4677 package-merge-liquid.json update more xcdl

## 2026-06-20

* 90a3081 micro-os-plus templates updates

## 2026-06-17

* b5d7b1a package-merge-liquid.json update xcdl-export
* 0b3e4c7 xpack-root.json update
* 882dca3 tests/xcdl files update
* 9e0e289 cmake & meson templates update

## 2026-06-16

* 81353d7 templates remove cdlPackage

## 2026-06-15

* 9bfd5b2 templates cmake - meson consistency
* ad54bd8 templates updates
* d783bce templates build-helper NOT IS_ABSOLUTE
* fcb0557 package-merge-liquid.json: update tests
* 15e3a67 template meson cleanups

## 2026-06-14

* d128ce3 xpack-root update
* 071fc8c add copilot-instructions
* 3476e71 .vscode empty cmake-kits
* e61e222 _micro-os-plus template add xcdl-export
* 68687c5 _micro-os-plus template update

## 2026-05-22

* 8cbce34 add cmake add_compare_files_test & add_qemu_test
* 82469e7 add scripts/compare-files.sh

## 2026-05-17

* 770559b templates config updates
* 7148fde package-merge-liquid.json: bump deps
* e4306f7 add scripts/show-coverage.sh
* 8d790cc CMakeLists.txt LANGUAGES CXX
* 92620ab README: add coverage
* 09954b1 package-merge-liquid.json: short-win-paths-properties
* 7050d51 platform object library cleanups
* 4a4da07 xpack_display_target_lists() update
* fdb7cc3 cosmetics
* 418450b add_compile_coverage_private_options
* 099e079 copyright notices reformat

## 2026-04-30

* 2562f9e package-merge-liquid bump micro-test-plus 4.0.0
* 5d397d3 common-options fix liquid
* c691192 .vscode/settings.json fix cmake formatOnSave
* bff7b31 platforms: README updates
* ab68d27 fix if hasObjectLibrary

## 2026-04-29

* 5983234 platforms: updates
* 415736f meson/common-options aarch64 -Og
* 85091bc common-options-library-liquid.cmake: xpack_global_common_options
* e6dcb63 common-functions.cmake: add size & objdump
* 672bb7e toolchains: aarch64 use -Og
* 059bd05 package-merge-liquid.json: bump deps

## 2026-03-23

* 9b3a70d package-merge-liquid: micro-test-plus 3.3.0
* a88605a add empty .npmignore
* b088baf move tests to sources

## 2026-03-17

* d4f5167 3.0.1
* ab4918d prepare v3.0.1
* a8f95f0 templates cosmetics
* c481dd8 more conditionals in platforms

## 2026-03-16

* 7df349b package*.json bump deps
* 81b9f48 test-ci.yml update
* 736517c 3.0.0
* 79db9c5 README update
* bd99d5d prepare v3.0.0
* 7ee89e3 move support code to template
* 9682e75 2.18.0

## 2026-03-15

* 3bdee46 templates project-definitions-liquid
* aefa86a meson: use define-executables
* f2476c4 top meson-liquid.build add xpack_project_name
* 72300aa fix cmake parenthesis
* 8b456c1 templates remove old
* e056672 templates xpack_enable_*
* 2f358c2 settings.json cmake defaultFormatter
* 8250db7 re-format cmake files
* 3296919 add aliases to meson platform libraries

## 2026-03-13

* 2201f8d generate-tests-commons.sh fix first time
* c80f759 template rework
* 1371bb4 tests/package-merge-liquid.json update
* 75ed21f generate-tests-commons.sh calculate platforms

## 2026-03-11

* b73299e templates/package-merge-liquid.json refer npm-packages-helper

## 2026-03-10

* fc65cfe package*.json update
* 39db587 maintenance-scripts: filter platforms
* 286c25a package-merge-liquid.json: matrix strategy
* 6401dd4 copyright 2026 update

## 2025-11-20

* 09cfdd0 rename npm-pack

## 2025-11-19

* 693c6e3 README update

## 2025-10-07

* 884a59c update copyright notices

## 2025-08-20

## 2025-08-20

* b05d63e 2.17.0
* 35cf689 prepare v2.17.0
* c462d9c templates add -Wno-psabi for gcc
* 55fb3d7 templates update copyright notices
* 3d83c03 update copyright licenses
* 1d7ba82 doxygen updates for 1.14.0

## 2025-05-18

* cef1230 Add -Wno-documentation to clang

## 2025-05-14

* 60d9d10 doxygen update configs to 1.13.2

## 2025-03-21

* 8e1e375 template: update for diag-trace

## 2025-03-20

* 2296a5b generate-tests-commons.sh: update --init

## 2025-03-19

* 6c50e69 cosmetise copyright notices

## 2025-03-15

* 5c97fb0 template/package: bump micro-test

## 2025-03-05

* c45296e generate-commons --init
* 9b9d8cf doxygen/custom.css --primary-color
* 62cbf9c .vscode/setting.json update
* ade530f cosmetics in DO NOT EDIT; add deps to micro-test-plus

## 2025-02-28

* fc7b0cb templates: copyright notices cosmetics
* 25da268 add templates & generate-commons.sh
* ffa7aa3 README update
* 00d1fc2 re-generate workflows
* e5e7051 move templates/old

## 2025-02-26

* 3561435 package.json: ninja.cmd
* debb720 README update
* 280f3a4 2.16.0
* 90a6ae6 README update
* 7097b3f prepare v2.15.1
* 0841517 package.json: bump deps
* 7573cca package*.json updates
* a9e98ba workflows/test-ci.yml update
* 1a5467e workflows/test-ci.yml update
* 5f731de re-generate commons

## 2025-02-24

* cb4c81b cmake/toolchains: use CMAKE_HOST_SYSTEM_NAME
* 27b25c7 cmake/toolchains: add explicit extensions
* 37ffb99 toolchain.cmake: add explicit extension
* 8ea91c5 get-library-paths.sh: rework
* 0820545 cmake: show INTERFACE_LINK_OPTIONS

## 2024-11-21

* 384e465 rename xpack-development
* 4eabde6 add templates
* f9ccbba shorten copyright notice
* 0270447 add dev-scripts
* c8c0cd0 update copyright notice

## 2023-11-28

* 98c7c3d add dev-scripts/sed-endif.sh (untested)
* 5f583dc git-commit.sh update
* 0312568 README updates
* c7d7cad package.json: cosmetise scripts
* 642ffd5 templates updates

## 2023-10-12

* 07e8e12 ci.yml: non-sudo npm install

## 2023-10-11

* 91a9d71 2.14.1
* e39d51d prepare v2.14.1
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
