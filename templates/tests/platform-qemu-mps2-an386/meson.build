#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2021 Liviu Ionescu
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# Create the test applications.

message('Processing tests/platform-qemu-mps2-an386...')

# -----------------------------------------------------------------------------

# Enable them only when needed.
xpack_create_listing = false
xpack_create_hex = false

# -----------------------------------------------------------------------------
# Define the platform library.

# https://mesonbuild.com/Reference-manual_functions.html#declare_dependency
platform_qemu_mps2_an386_dependency = declare_dependency(
  include_directories: include_directories(
    'include-platform',
  ),
  sources: files(
    # None.
  ),
  compile_args: [
    # None.
  ],
  dependencies: [
    micro_os_plus_devices_qemu_cortexm_dependency,
  ]
)

message('+ -I tests/platform-qemu-mps2-an386/include-platform')
message('+ tests/platform-qemu-mps2-an386/src/initialize-hardware.cpp')
message('+ tests/platform-qemu-mps2-an386/src/interrupts-handlers.cpp')
message('> platform_qemu_mps2_an386_dependency')

# =============================================================================
# Define the tests executables.

# Get the command names from the toolchain file.
size = find_program('size')
objdump = find_program('objdump')
objcopy = find_program('objcopy')

test_names = [ 'sample-test', 'unit-test' ]

foreach name : test_names

  compile_definitions = []

  libs_dependencies = [
    # Tested library.
    micro_os_plus_xxx_yyy_dependency,
  ]
  if name == 'unit-test'
    libs_dependencies += [
      # Portable dependencies.
      micro_os_plus_micro_test_plus_dependency,
      # micro_os_plus_diag_trace_dependency,
    ]
  endif
  libs_dependencies += [
    # Platform specific dependencies.
    platform_qemu_mps2_an386_dependency, # bring device & architecture too.

    micro_os_plus_libs_c_dependency,
    micro_os_plus_libs_cpp_dependency,
    micro_os_plus_semihosting_dependency,
    micro_os_plus_startup_dependency,
  ]

  # https://mesonbuild.com/Reference-manual.html#executable
  exe = executable(
    name,
    include_directories: include_directories(
      '../include',
      # 'include-config' # was added globally
    ),
    sources: files(
      '../src/' + name + '.cpp'
    ),
    c_args: compile_definitions,
    cpp_args: compile_definitions,
    dependencies: libs_dependencies,
    link_args: [
      '-nostartfiles',
      # Ensure the linker will keep the interrupt vectors which otherwise
      # are not refered from anywhere.
      '-u_interrupt_vectors',
      '-Wl,--gc-sections',
      '-Wl,-Map,'+ name + '-map.txt',
      # '-v',
      ] + xpack_linker_scripts,
    name_suffix: 'elf',
  )

  message('A+ -I tests/include')
  message('A+ tests/src/' + name + '.cpp')
  message('A> ' + name)

  # Leave the result in a variable with the test name.
  set_variable(name.underscorify(), exe)

  # https://mesonbuild.com/Reference-manual_functions.html#custom_target
  custom_target(
    name + '-size',

    input: exe,
    output: name + '.size',
    command: [
      size,
      '--format=berkeley',
      '@INPUT@'
    ],
    build_always_stale: true,
    build_by_default: true,
  )

  # --source --all-headers --demangle --line-numbers --wide "xxx.elf"
  custom_target(
    name + '-list',

    input: exe,
    output: name + '-list.txt',
    command: [
      objdump,
      '--source',
      '--all-headers',
      '--demangle',
      '--line-numbers',
      '--wide',
      '@INPUT@'
    ],
    build_always_stale: true,
    build_by_default: xpack_create_listing,
    capture: true,
  )

  # -O ihex "xxx.elf"
  custom_target(
    name + '-hex',

    input: exe,
    output: name + '.hex',
    command: [
      objcopy,
      '-O',
      'ihex',
      '@INPUT@',
      '@OUTPUT@',
    ],
    build_always_stale: true,
    build_by_default: xpack_create_hex,
  )

endforeach

qemu = find_program('qemu-system-arm')

# https://mesonbuild.com/Unit-tests.html#malloc_perturb_
nomalloc = environment({'MALLOC_PERTURB_': '0'})

# https://mesonbuild.com/Reference-manual_functions.html#test
test(
  'sample-test',
  qemu,
  args: [
    '--machine', 'mps2-an386',
    '--cpu', 'cortex-m4',
    '--kernel', sample_test,
    '--nographic',
    '-d', 'unimp,guest_errors',
    '--semihosting-config', 'enable=on,target=native',
    '--semihosting-config', 'arg=sample-test',
  ],
  env: nomalloc
)

# https://mesonbuild.com/Reference-manual_functions.html#test
test(
  'unit-test',
  qemu,
  args: [
    '--machine', 'mps2-an386',
    '--cpu', 'cortex-m4',
    '--kernel', unit_test,
    '--nographic',
    '-d', 'unimp,guest_errors',
    '--semihosting-config', 'enable=on,target=native',
    '--semihosting-config', 'arg=unit-test',
  ],
  env: nomalloc
)

# -----------------------------------------------------------------------------
