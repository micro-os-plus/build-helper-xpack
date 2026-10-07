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

// ----------------------------------------------------------------------------

using namespace micro_os_plus;

// ----------------------------------------------------------------------------

// The onboard green LED, used to signal general board activity.
platform::led_green activity_led;

// ----------------------------------------------------------------------------

// Called from _start(), before the data & bss sections are initialised,
// typically used to set up the system clock (so that the
// initialisations are faster) and possibly to enable external RAM.
// If any driver leaves values in RAM, they will be cleared and lost, so
// those drivers should reinitialise their RAM contents in the next hook.
// Requires MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_EARLY_ENABLED
// (startup-defines.h).
int
micro_os_plus_startup_initialise_hardware_early_hook (void)
{
  SystemCoreClock = system_clock.initialise ();
  return 0;
}

// Called from micro_os_plus_startup_run_main(), after the data & bss
// sections are initialised, typically used to finalise the hardware
// setup.
// Requires MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_ENABLED
// (startup-defines.h).
int
micro_os_plus_startup_initialise_hardware_hook (void)
{
  SystemInit ();

  trace::printf ("SystemCoreClock: %lu Hz\n", SystemCoreClock);

  return 0;
}

// Called from micro_os_plus_startup_run_main(), after the static
// initialisers have run.
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
