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

// Only the Pico SDK's register-definition headers are used below (no SDK
// library is linked); they provide the peripheral bit-field names used to
// drive GPIO25, matching the CMSIS register structs already pulled in via
// micro-os-plus/device.h (RP2040.h), the same way rp2040/system-clock.cpp
// uses CLOCKS->..., XOSC->..., PLL_SYS->....
#include "hardware/platform_defs.h"
#include "hardware/regs/io_bank0.h"
#include "hardware/regs/resets.h"

#include <cstdint>

// ----------------------------------------------------------------------------

// The SIO/IO_BANK0/RESETS macros above expand to C-style pointer casts
// (e.g. `((SIO_Type*) SIO_BASE)`); silence the resulting warning at
// each expansion site below, since micro-os-plus/device.h only covers
// casts made while parsing RP2040.h itself, not macro uses here.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
#endif // defined(__GNUC__)

namespace platform
{
  // GPIO25 is the only pin the onboard green LED is wired to; no other
  // board revision moves it.
  static constexpr std::uint32_t led_pin_mask = 1u << 25;

  void
  led_green::power_up (void)
  {
    // IO_BANK0, PADS_BANK0 and SIO are clocked from clk_sys, which is
    // already running (off the ROSC) straight out of reset, well before
    // system_clock.initialise() (system-clock.cpp) ever runs, so no clock
    // setup is
    // needed here, unlike clk_peri-fed peripherals (UART/SPI/ADC).
    // clk_sys to each of them can be independently gated via
    // CLOCKS->WAKE_EN0 (CLK_SYS_IO/CLK_SYS_PADS/CLK_SYS_SIO bits), but
    // WAKE_EN0 resets to all-ones (all gates enabled) and nothing in
    // this codebase ever writes to it, so the gates are assumed open;
    // if something elsewhere ever clears those bits for power saving,
    // this driver would need to set them here first.

    // Release IO_BANK0 and PADS_BANK0 from reset before touching their
    // registers (harmless if the bootrom already did so).
    RESETS->RESET
        &= ~(RESETS_RESET_IO_BANK0_BITS | RESETS_RESET_PADS_BANK0_BITS);
    while ((RESETS->RESET_DONE
            & (RESETS_RESET_IO_BANK0_BITS | RESETS_RESET_PADS_BANK0_BITS))
           != (RESETS_RESET_IO_BANK0_BITS | RESETS_RESET_PADS_BANK0_BITS))
      {
        // Busy wait for both peripherals to come out of reset.
      }

    // Route GPIO25 to the SIO peripheral (plain digital I/O), leaving
    // the pad's drive/pull/schmitt configuration at its reset default.
    IO_BANK0->GPIO25_CTRL = (IO_BANK0_GPIO25_CTRL_FUNCSEL_VALUE_SIO_25
                             << IO_BANK0_GPIO25_CTRL_FUNCSEL_LSB);

    // Drive low before enabling the output, so the LED does not
    // glitch on while SIO_OUT still holds its reset value.
    SIO->GPIO_OUT_CLR = led_pin_mask;
    SIO->GPIO_OE_SET = led_pin_mask;
  }

  void
  led_green::turn_on (void)
  {
    // Active-high: set the pin to turn the LED on.
    SIO->GPIO_OUT_SET = led_pin_mask;
  }

  void
  led_green::turn_off (void)
  {
    // Active-high: clear the pin to turn the LED off.
    SIO->GPIO_OUT_CLR = led_pin_mask;
  }

  void
  led_green::toggle (void)
  {
    SIO->GPIO_OUT_XOR = led_pin_mask;
  }

  void
  led_green::power_down (void)
  {
    // Disable the output driver first, then return the pin to its
    // reset function (NULL, not routed to any peripheral).
    SIO->GPIO_OE_CLR = led_pin_mask;
    IO_BANK0->GPIO25_CTRL = (IO_BANK0_GPIO25_CTRL_FUNCSEL_VALUE_NULL
                             << IO_BANK0_GPIO25_CTRL_FUNCSEL_LSB);
  }

} // namespace platform

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------
