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

// ----------------------------------------------------------------------------

// The CMSIS/HAL/BSP headers pulled in below (transitively, via `main.h`)
// use C-style casts and, in the CMSIS core inline functions, casts that
// are useless in C but not in C++; silence both for this translation
// unit, matching `micro-os-plus/device.h`.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
#pragma GCC diagnostic ignored "-Wuseless-cast"
#endif // defined(__GNUC__)

namespace platform
{
  void
  led_green::power_up (void)
  {
    // Harmless to call again even though `cubemx_main()`, called from
    // `micro_os_plus_startup_initialise_hardware_hook()`, already did
    // so before this driver ever runs.
    BSP_LED_Init (LED_GREEN);
  }

  void
  led_green::turn_on (void)
  {
    BSP_LED_On (LED_GREEN);
  }

  void
  led_green::turn_off (void)
  {
    BSP_LED_Off (LED_GREEN);
  }

  void
  led_green::toggle (void)
  {
    BSP_LED_Toggle (LED_GREEN);
  }

  void
  led_green::power_down (void)
  {
    BSP_LED_DeInit (LED_GREEN);
  }

} // namespace platform

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------
