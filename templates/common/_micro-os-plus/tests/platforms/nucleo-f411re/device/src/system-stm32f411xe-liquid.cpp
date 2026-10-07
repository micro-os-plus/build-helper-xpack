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

#include "micro-os-plus/device.h"

// ----------------------------------------------------------------------------

// Replaces the CubeMX-generated `system_stm32f4xx.c` (removed from the
// build, see device/CMakeLists.txt), whose `SystemCoreClock` is a
// `.data` global (initialised to `16000000`); the value any hook writes
// to it before `_start()` copies `.data` from flash would otherwise be
// overwritten by that copy. Declaring it here without an initialiser
// puts it in `.bss` instead (zero at that point, then correctly filled
// in below, by `SystemInit()`, once `.bss` has already been cleared).
extern "C" uint32_t SystemCoreClock;
uint32_t SystemCoreClock;

// A private instance, used only to read back the clock configuration;
// distinct from the one `src/hooks.cpp` uses to bring the clock up in
// `micro_os_plus_startup_initialise_hardware_early_hook()`, since
// `device::system_clock` carries no state of its own.
device::system_clock system_clock;

extern "C" void
SystemInit (void)
{
  SystemCoreClockUpdate ();
}

extern "C" void
SystemCoreClockUpdate (void)
{
  SystemCoreClock = system_clock.clock_get_frequency_hz ();
}

// ----------------------------------------------------------------------------
