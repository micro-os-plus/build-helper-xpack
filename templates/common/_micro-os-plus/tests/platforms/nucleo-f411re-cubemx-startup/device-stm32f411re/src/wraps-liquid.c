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
#include "micro-os-plus/startup.h"

// ----------------------------------------------------------------------------

// Trick to intercept the call from _start(), since we need to do a
// little bit more than STM32CubeMX initialization.
int
__wrap_main (void)
{
  micro_os_plus_startup_run_main ();

  while (1)
    {
      __WFI (); // Wait For Interrupt
    }
}

void
__wrap___libc_init_array (void)
{
  // Silence this call, the static initializers are later called in the
  // micro_os_plus_startup_run_main() right before calling main().
}

// ----------------------------------------------------------------------------
