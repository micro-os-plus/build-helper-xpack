/*
 * DO NOT EDIT! Automatically generated from template file:
 * {{fromFilePath}}
 *
 * This file is part of the µOS++ project (https://micro-os-plus.github.io/).
 * Copyright (c) 2026 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can be
 * obtained from https://opensource.org/licenses/mit.
 */

// ----------------------------------------------------------------------------

#include "micro-os-plus/architecture.h"
#include "micro-os-plus/diag/trace.h"
#include "micro-os-plus/startup.h"

// ----------------------------------------------------------------------------

// Declared (.global, not .weak) in crt0_riscv.S, part of pico_crt0 (always
// linked here, unlike pico_runtime); calling it directly by name -- rather
// than overriding the .weak runtime_init() crt0_riscv.S also provides --
// avoids a multiple-definition conflict should some other configuration of
// this platform ever also link pico_runtime, which supplies its own
// runtime_init(). Clears the Hazard3 IRQ-force-array bits, enables only
// mie.MEIE (external IRQs; timer/software IRQ enables stay clear), sets
// mstatus.MIE, and clears mscratch. Normally called from the full
// pico_runtime dispatcher's runtime_init(), which this platform does not
// link. It is also registered in `__preinit_array` (by
// `pico_runtime_init`), so it runs a second time, together with the
// other SDK runtime initialisers, from `micro_os_plus_run_init_array()`;
// this is harmless, since it only clears and sets the same bits. It is
// called early here for parity with the Arm-sdk sibling, which calls
// `runtime_init_per_core_enable_coprocessors()` the same way, right
// here.
extern void
runtime_init_per_core_h3_irq_registers (void);

void
__wrap_main (void);
void
__wrap___libc_init_array (void);

void
__wrap_main (void)
{
  runtime_init_per_core_h3_irq_registers ();

  // Call the µOS++ startup code to do some more initialisations,
  // prepare the semihosting environment, run static initializers,
  // then main() with argc/argv parameters and exit(code).
  // Note: requires MICRO_OS_PLUS_STARTUP_CALL_REAL_MAIN_ENABLED.
  micro_os_plus_startup_run_main ();

#if defined(MICRO_OS_PLUS_DEBUG_ENABLED)
  micro_os_plus_architecture_brk ();
#endif
  while (1)
    {
      micro_os_plus_architecture_wfi ();
    }
}

void
__wrap___libc_init_array (void)
{
  // Silence this call, the static initializers are later called in the
  // micro_os_plus_startup_run_main() right before calling main().
  // Note the three underscores: `-Wl,--wrap=__libc_init_array` redirects
  // the calls to `__wrap_` + `__libc_init_array`.
}

// ----------------------------------------------------------------------------
// Link-time tripwires.
//
// This platform must not link `pico_stdio`, `pico_printf` or
// `pico_malloc` (they come with `pico_stdlib`/`pico_runtime`; see
// CMakeLists.txt and README.md). If they return, the build would still
// succeed, but with `printf()`/`puts()` redirected to the SDK stdio
// drivers (the test report lost from semihosting), the SDK formatter
// replacing Newlib's, and the SDK `malloc()` wrappers.
//
// Each of these libraries defines the `__wrap_*` symbol below; defining
// it here too turns their presence into a `multiple definition` link
// error, naming the offending symbol. The SDK libraries are compiled as
// objects directly into the executable (CMake INTERFACE libraries, not
// archives), so the duplicate is always detected, before
// `--gc-sections` discards these unused functions.
//
// The functions are never called; should one be reached (a `--wrap`
// option present without its library), trap rather than misbehave.

void
__wrap_printf (void); // Defined by `pico_stdio`.
void
__wrap_vsnprintf (void); // Defined by `pico_printf`.
void
__wrap_malloc (void); // Defined by `pico_malloc`.

static void
tripwire_trap (void)
{
#if defined(MICRO_OS_PLUS_DEBUG_ENABLED)
  micro_os_plus_architecture_brk ();
#endif
  while (1)
    {
      micro_os_plus_architecture_wfi ();
    }
}

void
__wrap_printf (void)
{
  tripwire_trap ();
}

void
__wrap_vsnprintf (void)
{
  tripwire_trap ();
}

void
__wrap_malloc (void)
{
  tripwire_trap ();
}

// ----------------------------------------------------------------------------

#if defined(NDEBUG)
void
hard_assertion_failure (void)
{
  micro_os_plus_trace_puts ("Hard assert");

#if defined(MICRO_OS_PLUS_DEBUG_ENABLED)
  micro_os_plus_architecture_brk ();
#endif
  while (1)
    {
      micro_os_plus_architecture_wfi ();
    }
}
#endif // defined(NDEBUG)

// ----------------------------------------------------------------------------
