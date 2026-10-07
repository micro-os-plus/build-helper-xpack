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

#ifndef MICRO_OS_PLUS_RASPBERRY_PI_PICO_2_ARM_SDK_LED_GREEN_H_
#define MICRO_OS_PLUS_RASPBERRY_PI_PICO_2_ARM_SDK_LED_GREEN_H_

// ----------------------------------------------------------------------------

// This is a C++ only header (the driver is a class, not a C API); do not
// include it from C translation units.
#if defined(__cplusplus)

namespace platform
{
  // Driver for the Raspberry Pi Pico 2 onboard green LED
  // (`PICO_DEFAULT_LED_PIN`), implemented on top of the Pico SDK's own
  // `hardware_gpio` driver (`hardware/gpio.h`), unlike the sibling
  // raspberry-pi-pico-2-arm platform, which drives the RP2350 CMSIS
  // register structs directly. This platform already links the Pico
  // SDK proper (pico_crt0/pico_runtime_init/pico_standard_link), so
  // there is no reason to bypass its GPIO driver here.
  class led_green
  {
  public:
    led_green () = default;

    led_green (const led_green&) = delete;
    led_green&
    operator= (const led_green&)
        = delete;

    ~led_green () = default;

    // Initialise the pin (Pico SDK `gpio_init()`) and set it as an
    // output driven low (LED off).
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

    // Return the pin to its unclaimed (`gpio_deinit()`) state.
    void
    power_down (void);
  };
} // namespace platform

#endif // defined(__cplusplus)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_RASPBERRY_PI_PICO_2_ARM_SDK_LED_GREEN_H_

// ----------------------------------------------------------------------------
