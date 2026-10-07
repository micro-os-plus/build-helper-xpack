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

#include "micro-os-plus/platform.h"
#include "micro-os-plus/startup.h"
#include "micro-os-plus/diag/trace.h"
#include "hardware/clocks.h"
#include "pico/runtime_init.h"

// ----------------------------------------------------------------------------

using namespace micro_os_plus;

// ----------------------------------------------------------------------------

// Called from micro_os_plus_startup_run_main() (via __wrap_main() in
// wraps.c), after the data & bss sections are initialised, but BEFORE
// the preinit/init arrays run.
//
// This project does not link `pico_runtime`, so crt0 calls only the
// empty weak `runtime_init()` stub. The pico-sdk runtime initialisers
// are registered by the linked SDK libraries in `__preinit_array` (via
// `PICO_RUNTIME_INIT_FUNC*()`), and are run by
// `micro_os_plus_run_init_array()`, before the C++ static constructors.
//
// The first hardware steps (early resets, USB power down,
// clocks, post-clock resets) are
// excluded from `__preinit_array` (via the `PICO_RUNTIME_SKIP_INIT_*`
// definitions in CMakeLists.txt) and are called here instead, in the
// same SDK order, so that the clocks are available early, for example
// to report the frequency right after the CPU identification. Each step
// still runs exactly once; the remaining initialisers (spin locks,
// mutexes, IRQ priorities, etc.) follow from `__preinit_array`.
// Requires MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_ENABLED
// (startup-defines.h).
int
micro_os_plus_startup_initialise_hardware_hook (void)
{
  runtime_init_early_resets ();
  runtime_init_usb_power_down ();
  runtime_init_clocks ();
  runtime_init_post_clock_resets ();

  trace::printf ("SystemCoreClock: %lu Hz\n", clock_get_hz (clk_sys));

  return 0;
}

// ----------------------------------------------------------------------------

extern platform::led_green activity_led;

// Called from micro_os_plus_startup_run_main() (via __wrap_main() in
// wraps.c), after the preinit/init arrays have run; the clocks are
// initialised at this point, and activity_led (a static object) is
// already constructed.
// Requires MICRO_OS_PLUS_STARTUP_POST_INIT_ARRAY_ENABLED (startup-defines.h).
int
micro_os_plus_startup_post_init_array_hook (void)
{
  activity_led.power_up ();
  activity_led.turn_on ();

  return 0;
}

// Called from micro_os_plus_startup_exit() right before the
// application session terminates (semihosting exit or hardware reset).
// Requires MICRO_OS_PLUS_STARTUP_FINALISE_HARDWARE_ENABLED
// (startup-defines.h).
void
micro_os_plus_startup_finalise_hardware_hook (void)
{
  activity_led.turn_off ();
  activity_led.power_down ();
}

// ----------------------------------------------------------------------------
