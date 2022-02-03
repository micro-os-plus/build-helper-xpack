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

# Script to generate the vendor_xxxx.c from the Arm assembly file.

if [ $# -lt 1 ]
then
  echo "Using: bash $(basename $0) <arm-file>.s"
  exit 1
fi

TAB=$'\t'
TMP_FILE=$(mktemp -q /tmp/cmsis_vectors.XXXXXX)

cat "$1" | \
sed -n -e '/^__Vectors/,/^__Vectors_End/p' | \
sed -e '/^__Vectors_End/,$d' | \
sed -e '1,16d' | \
sed -e 's|__Vectors||' | \
sed -E 's|[[:space:]]*DCD[[:space:]]*||' | \
sed -E 's|[[:space:]]+$||' \
> "${TMP_FILE}"

current_year=$(date +"%Y")

# Note: __EOF__ is NOT quoted to allow substitutions.
cat <<__EOF__
/*
 * This file is part of the µOS++ distribution.
 *   (https://github.com/micro-os-plus)
 * Copyright (c) ${current_year} Liviu Ionescu.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/MIT/.
 */

/*
 * The list of external handlers was automatically generated by
 * processing the files available in the CubeMX packages, the folder:
 * \`/Drivers/CMSIS/Device/ST/STM32F?xx/Source/Templates/arm\`
 */

// clang-format off
// ----------------------------------------------------------------------------

#include <micro-os-plus/architecture.h>
#include <micro-os-plus/architecture-cortexm/exception-handlers.h>

// ----------------------------------------------------------------------------

void __attribute__((weak))
Default_Handler(void);

/*
 * Forward declaration of the specific IRQ handlers. These are aliased
 * to the Default_Handler, which is a 'forever' loop. When the application
 * defines an actual handler (with the same name), it will automatically
 * take precedence over these weak definitions.
 */

__EOF__

cat "${TMP_FILE}" | \
sed -e '/^0/d' | \
sed -E '/^[[:space:]]+/d' | \
sed -e '/^$/d' | \
sed -E 's|[[:space:]]+[;] .*$||' | \
sed -e 's|.*|void __attribute__ ((weak, alias ("Default_Handler")))\
&(void);|'

echo

# Note: __EOF__ is NOT quoted to allow substitutions.
cat <<__EOF__
// ----------------------------------------------------------------------------

extern uint32_t _initial_main_stack_pointer;

typedef void
(*handler_ptr_t)(void);

// ----------------------------------------------------------------------------

#pragma GCC diagnostic push

#pragma GCC diagnostic ignored "-Wpedantic"

/**
 * The table of interrupt handlers. It has an explicit section name
 * and relies on the linker script to place it at the correct location
 * in memory, usually at the very beginning of the flash bank.
 */
__attribute__ ((section(".interrupt_vectors"),used))
handler_ptr_t _interrupt_vectors[] =
  {
    // Cortex-M Core Handlers
    (handler_ptr_t) &_initial_main_stack_pointer, // MSP
    Reset_Handler,                     // The reset handler

    NMI_Handler,                       // The NMI handler
    HardFault_Handler,                 // The hard fault handler

#if defined(__ARM_ARCH_7M__) || defined(__ARM_ARCH_7EM__)
    MemManage_Handler,                 // The MPU fault handler
    BusFault_Handler,                  // The bus fault handler
    UsageFault_Handler,                // The usage fault handler
#else
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
#endif
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    SVC_Handler,                       // SVCall handler
#if defined(__ARM_ARCH_7M__) || defined(__ARM_ARCH_7EM__)
    DebugMon_Handler,                  // Debug monitor handler
#else
    0,                                 // Reserved
#endif
    0,                                 // Reserved
    PendSV_Handler,                    // The PendSV handler
    SysTick_Handler,                   // The SysTick handler

    // ------------------------------------------------------------------------
__EOF__

cat "${TMP_FILE}" | \
sed -E '/^[[:space:]]*$/d' | \
sed -E 's|^[[:space:]]*;|;|' | \
sed -e 's|^0|0,|' | \
sed -e 's|_IRQHandler|_IRQHandler,|' | \
sed -e 's|_Handler|_Handler,|' | \
sed -e 's|;|\/\/|' | \
sed -e 's|^|    |'

cat <<__EOF__
};

#pragma GCC diagnostic pop

// ----------------------------------------------------------------------------

/**
 * The processor ends up here if an unexpected interrupt occurs or a
 * specific handler is not present in the application code.
 * When in DEBUG, trigger a debug exception to clearly notify
 * the user of the exception and help identify the cause.
 */
void __attribute__ ((section(".after_vectors")))
Default_Handler(void)
{
#if defined(DEBUG)
  micro_os_plus_architecture_brk();
#endif
  while (1)
    {
      ;
    }
}

// ----------------------------------------------------------------------------
__EOF__

rm "${TMP_FILE}"

# -----------------------------------------------------------------------------
