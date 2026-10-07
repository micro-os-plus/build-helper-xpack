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

// The Pico SDK's own GPIO driver; PICO_DEFAULT_LED_PIN comes from the
// board header (boards/pico2.h), force-included by the SDK's CMake
// build via the generated pico/config_autogen.h, no explicit include
// needed for it here.
#include "hardware/gpio.h"

// ----------------------------------------------------------------------------

namespace platform
{
  void
  led_green::power_up (void)
  {
    // gpio_init() sets the pin to input, preloads the output latch to
    // low, then routes it to SIO (also clearing the RP2350 pad's ISO
    // isolation latch, unlike the RP2040) -- see the Pico SDK's
    // gpio_init()/gpio_set_function() in hardware_gpio/gpio.c.
    gpio_init (PICO_DEFAULT_LED_PIN);

    // Switch to output, still driving low (LED off) from the preload
    // above.
    gpio_set_dir (PICO_DEFAULT_LED_PIN, GPIO_OUT);
  }

  void
  led_green::turn_on (void)
  {
    // Active-high: drive the pin high to turn the LED on.
    gpio_put (PICO_DEFAULT_LED_PIN, true);
  }

  void
  led_green::turn_off (void)
  {
    // Active-high: drive the pin low to turn the LED off.
    gpio_put (PICO_DEFAULT_LED_PIN, false);
  }

  void
  led_green::toggle (void)
  {
    gpio_xor_mask (1u << PICO_DEFAULT_LED_PIN);
  }

  void
  led_green::power_down (void)
  {
    // Returns the pin to its GPIO_FUNC_NULL (unclaimed) state; does not
    // re-isolate the RP2350 pad, matching gpio_deinit()'s own scope.
    gpio_deinit (PICO_DEFAULT_LED_PIN);
  }

} // namespace platform

// ----------------------------------------------------------------------------

// The onboard green LED, used to signal general board activity. Unlike
// the raspberry-pi-pico-2-arm platform, there is no
// initialise_hardware_early_hook here; the clocks are brought up in
// initialise_hardware_hook below instead (see the comment there for
// why this differs from a plain pico-sdk application).
platform::led_green activity_led;

// ----------------------------------------------------------------------------
