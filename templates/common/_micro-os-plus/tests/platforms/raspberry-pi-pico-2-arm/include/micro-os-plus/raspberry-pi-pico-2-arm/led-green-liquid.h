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

#ifndef MICRO_OS_PLUS_RASPBERRY_PI_PICO_2_ARM_LED_GREEN_H_
#define MICRO_OS_PLUS_RASPBERRY_PI_PICO_2_ARM_LED_GREEN_H_

// ----------------------------------------------------------------------------

// This is a C++ only header (the driver is a class, not a C API); do not
// include it from C translation units.
#if defined(__cplusplus)

namespace platform
{
  // Driver for the Raspberry Pi Pico 2 onboard green LED, wired to
  // GPIO25, active-high, with no series resistor other than the
  // RP2350 pad driver. Implemented directly on the RP2350 CMSIS
  // register structs (SIO, IO_BANK0, PADS_BANK0, RESETS), matching
  // the raw-register approach used by rp2350/system-clock.cpp; no Pico
  // SDK runtime dependency.
  class led_green
  {
  public:
    led_green () = default;

    led_green (const led_green&) = delete;
    led_green&
    operator= (const led_green&)
        = delete;

    ~led_green () = default;

    // Release IO_BANK0/PADS_BANK0 from reset, route GPIO25 to SIO,
    // and enable it as an output driven low (LED off).
    void
    power_up (void);

    // Drive GPIO25 high (LED on; the LED is active-high).
    void
    turn_on (void);

    // Drive GPIO25 low (LED off; the LED is active-high).
    void
    turn_off (void);

    // Invert the current output level.
    void
    toggle (void);

    // Disable the output driver and return GPIO25 to its reset
    // function (NULL, not routed to any peripheral).
    void
    power_down (void);
  };
} // namespace platform

#endif // defined(__cplusplus)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_RASPBERRY_PI_PICO_2_ARM_LED_GREEN_H_

// ----------------------------------------------------------------------------
