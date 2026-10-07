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

// The CMSIS/HAL headers pulled in below (transitively, via `main.h`) use
// C-style casts and, in the CMSIS core inline functions, casts that are
// useless in C but not in C++; silence both for this translation unit,
// matching `micro-os-plus/device.h`.
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
    // Initialise the pin (mode, pull, speed), the same way as the
    // CubeMX-generated `MX_GPIO_Init()` (`cubemx_main()`).
    GPIO_InitTypeDef GPIO_InitStruct = {};
    GPIO_InitStruct.Pin = LD1_Pin;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init (LD1_GPIO_Port, &GPIO_InitStruct);

    // Active-high: start with the LED off.
    HAL_GPIO_WritePin (LD1_GPIO_Port, LD1_Pin, GPIO_PIN_RESET);
  }

  void
  led_green::turn_on (void)
  {
    // Active-high: drive the pin high to turn the LED on.
    HAL_GPIO_WritePin (LD1_GPIO_Port, LD1_Pin, GPIO_PIN_SET);
  }

  void
  led_green::turn_off (void)
  {
    // Active-high: drive the pin low to turn the LED off.
    HAL_GPIO_WritePin (LD1_GPIO_Port, LD1_Pin, GPIO_PIN_RESET);
  }

  void
  led_green::toggle (void)
  {
    HAL_GPIO_TogglePin (LD1_GPIO_Port, LD1_Pin);
  }

  void
  led_green::power_down (void)
  {
    // Returns the pin to its reset (analog input, no pull) state.
    HAL_GPIO_DeInit (LD1_GPIO_Port, LD1_Pin);
  }

} // namespace platform

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------
