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
#include "micro-os-plus/rp2350-riscv/registers.h"

// Only the Pico SDK's register-definition headers are used below (no SDK
// library is linked, and no `hardware_structs`/CMSIS dependency -- see
// rp2350/registers.h); they provide the peripheral base addresses and
// bit-field names used to drive GPIO25, the same way
// rp2350/system-clock.cpp uses them to drive CLOCKS/XOSC/PLL_SYS.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wundef" // PICO_RP2350A, only used by the
// SDK's own CMake build.
#endif // defined(__GNUC__)
#include "hardware/platform_defs.h"
#include "hardware/regs/addressmap.h"
#include "hardware/regs/io_bank0.h"
#include "hardware/regs/pads_bank0.h"
#include "hardware/regs/resets.h"
#include "hardware/regs/sio.h"
#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

#include <cstdint>

// ----------------------------------------------------------------------------

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
    // system_clock.initialise() (system-clock.cpp) ever runs, so no
    // clock setup is needed here, unlike clk_peri-fed peripherals
    // (UART/SPI/ADC). clk_sys to each of them can be independently
    // gated via CLOCKS_WAKE_EN0 (CLK_SYS_IO/CLK_SYS_PADS/CLK_SYS_SIO
    // bits), but WAKE_EN0 resets to all-ones (all gates enabled) and
    // nothing in this codebase ever writes to it, so the gates are
    // assumed open; if something elsewhere ever clears those bits for
    // power saving, this driver would need to set them here first.

    // Release IO_BANK0 and PADS_BANK0 from reset before touching their
    // registers (harmless if the bootrom already did so).
    RP2350_REG32 (RESETS_BASE, RESETS_RESET_OFFSET)
        &= ~(RESETS_RESET_IO_BANK0_BITS | RESETS_RESET_PADS_BANK0_BITS);
    while ((RP2350_REG32 (RESETS_BASE, RESETS_RESET_DONE_OFFSET)
            & (RESETS_RESET_IO_BANK0_BITS | RESETS_RESET_PADS_BANK0_BITS))
           != (RESETS_RESET_IO_BANK0_BITS | RESETS_RESET_PADS_BANK0_BITS))
      {
        // Busy wait for both peripherals to come out of reset.
      }

    // Route GPIO25 to the SIO peripheral (plain digital I/O), leaving
    // the pad's drive/pull/schmitt configuration at its reset default.
    RP2350_REG32 (IO_BANK0_BASE, IO_BANK0_GPIO25_CTRL_OFFSET)
        = (IO_BANK0_GPIO25_CTRL_FUNCSEL_VALUE_SIO_25
           << IO_BANK0_GPIO25_CTRL_FUNCSEL_LSB);

    // Unlike the RP2040, the RP2350 pad starts isolated (ISO defaults
    // to 1 on every reset, not just when woken from a low-power mode);
    // while isolated, the pad ignores whatever SIO drives and the LED
    // never lights, regardless of GPIO_OUT/GPIO_OE. Clear it now that
    // SIO is the selected function, matching the order the Pico SDK's
    // gpio_set_function() uses (FUNCSEL first, then ISO).
    RP2350_REG32 (PADS_BANK0_BASE, PADS_BANK0_GPIO25_OFFSET)
        &= ~PADS_BANK0_GPIO25_ISO_BITS;

    // Drive low before enabling the output, so the LED does not
    // glitch on while SIO_OUT still holds its reset value.
    RP2350_REG32 (SIO_BASE, SIO_GPIO_OUT_CLR_OFFSET) = led_pin_mask;
    RP2350_REG32 (SIO_BASE, SIO_GPIO_OE_SET_OFFSET) = led_pin_mask;
  }

  void
  led_green::turn_on (void)
  {
    // Active-high: set the pin to turn the LED on.
    RP2350_REG32 (SIO_BASE, SIO_GPIO_OUT_SET_OFFSET) = led_pin_mask;
  }

  void
  led_green::turn_off (void)
  {
    // Active-high: clear the pin to turn the LED off.
    RP2350_REG32 (SIO_BASE, SIO_GPIO_OUT_CLR_OFFSET) = led_pin_mask;
  }

  void
  led_green::toggle (void)
  {
    RP2350_REG32 (SIO_BASE, SIO_GPIO_OUT_XOR_OFFSET) = led_pin_mask;
  }

  void
  led_green::power_down (void)
  {
    // Disable the output driver first, then return the pin to its
    // reset function (NULL, not routed to any peripheral).
    RP2350_REG32 (SIO_BASE, SIO_GPIO_OE_CLR_OFFSET) = led_pin_mask;
    RP2350_REG32 (IO_BANK0_BASE, IO_BANK0_GPIO25_CTRL_OFFSET)
        = (IO_BANK0_GPIO25_CTRL_FUNCSEL_VALUE_NULL
           << IO_BANK0_GPIO25_CTRL_FUNCSEL_LSB);
  }

} // namespace platform

// ----------------------------------------------------------------------------
