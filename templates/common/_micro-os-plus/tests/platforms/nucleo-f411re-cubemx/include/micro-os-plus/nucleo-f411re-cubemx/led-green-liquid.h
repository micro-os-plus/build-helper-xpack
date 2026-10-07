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

#ifndef MICRO_OS_PLUS_NUCLEO_F411RE_CUBEMX_LED_GREEN_H_
#define MICRO_OS_PLUS_NUCLEO_F411RE_CUBEMX_LED_GREEN_H_

// ----------------------------------------------------------------------------

// This is a C++ only header (the driver is a class, not a C API); do not
// include it from C translation units.
#if defined(__cplusplus)

namespace platform
{
  // Driver for the Nucleo-F411RE onboard green LED (`LD2`, `PA5`),
  // implemented on top of the STM32F4xx HAL's `hardware_gpio`-equivalent
  // driver (`stm32f4xx_hal_gpio.c`, already linked in via
  // `stm32cubemx-drivers-objects-library`), matching the approach used
  // by the sibling raspberry-pi-pico-sdk platform, which drives its
  // onboard LED via the Pico SDK's own `hardware_gpio` driver rather
  // than bare registers.
  class led_green
  {
  public:
    led_green () = default;

    led_green (const led_green&) = delete;
    led_green&
    operator= (const led_green&)
        = delete;

    ~led_green () = default;

    // Configure the pin and drive it low (LED off).
    void
    power_up (void);

    // Drive the pin high (LED on; the LED is active-high).
    void
    turn_on (void);

    // Drive the pin low (LED off; the LED is active-high).
    void
    turn_off (void);

    // Invert the current output level.
    void
    toggle (void);

    // Return the pin to its reset (analog input, no pull) state via
    // `HAL_GPIO_DeInit()`.
    void
    power_down (void);
  };
} // namespace platform

#endif // defined(__cplusplus)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_NUCLEO_F411RE_CUBEMX_LED_GREEN_H_

// ----------------------------------------------------------------------------
