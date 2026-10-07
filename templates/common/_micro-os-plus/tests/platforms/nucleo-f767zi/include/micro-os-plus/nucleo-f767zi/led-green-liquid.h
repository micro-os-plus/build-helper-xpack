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

#ifndef MICRO_OS_PLUS_NUCLEO_F767ZI_LED_GREEN_H_
#define MICRO_OS_PLUS_NUCLEO_F767ZI_LED_GREEN_H_

// ----------------------------------------------------------------------------

// This is a C++ only header (the driver is a class, not a C API); do not
// include it from C translation units.
#if defined(__cplusplus)

namespace platform
{
  // Driver for the Nucleo-F767ZI onboard green LED (`LD1`, `PB0`),
  // implemented directly on the STM32F767 CMSIS register structs
  // (`RCC`, `GPIOB`), matching the raw-register approach used by the
  // sibling nucleo-f411re platform, unlike the nucleo-f767zi-cubemx
  // platform, which drives the pin via the STM32F7xx HAL's
  // `HAL_GPIO_*()` calls.
  class led_green
  {
  public:
    led_green () = default;

    led_green (const led_green&) = delete;
    led_green&
    operator= (const led_green&)
        = delete;

    ~led_green () = default;

    // Enable the GPIOB clock and configure PB0 as a general-purpose
    // output, push-pull, no pull, driven low (LED off).
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

    // Return the pin to its reset function (analog, not routed to any
    // peripheral).
    void
    power_down (void);
  };
} // namespace platform

#endif // defined(__cplusplus)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_NUCLEO_F767ZI_LED_GREEN_H_

// ----------------------------------------------------------------------------
