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

#ifndef MICRO_OS_PLUS_STM32F767ZI_SYSTEM_CLOCK_H_
#define MICRO_OS_PLUS_STM32F767ZI_SYSTEM_CLOCK_H_

// ----------------------------------------------------------------------------

// This is a C++ only header (the driver is a class, not a C API); do not
// include it from C translation units.
#if defined(__cplusplus)

#include <cstdint>

namespace device
{
  // Driver bringing up the STM32F767 system clock on HSE, in bypass
  // mode (HSI, used by an earlier revision of this driver and by an
  // earlier revision of the sibling nucleo-f767zi-cubemx platform's
  // CubeMX-generated `SystemClock_Config()`, is accurate to roughly
  // ±1% over temperature; HSE, crystal-derived, is typically better
  // than ±50 ppm); implemented directly on the CMSIS `RCC`/`FLASH`/
  // `PWR` register structs (no HAL calls).
  //
  // Nucleo-F767ZI's `PH0/OSC_IN` is wired, per the `.ioc`
  // (`PH0/OSC_IN.Mode=HSE-External-Clock-Source`, `RCC.HSE_VALUE=
  // 16000000`), to receive the MCO output of the onboard ST-LINK/
  // V2-1's own STM32F103CBT6, at a nominal 16 MHz. Confirmed working
  // on real hardware (unlike the sibling nucleo-h533re platform,
  // where the equivalent attempt hung on `HSERDY`, indicating that
  // board's ST-Link clock does not reach the target's HSE pin; an
  // earlier revision of F767ZI's `.ioc` labelled `PH0/OSC_IN` with the
  // actual MCO source, `MCO [STM32F103CBT6_PA8]`, which H533RE's
  // never did — an early hint the two boards' ST-Link wiring
  // differs).
  //
  // Like the sibling nucleo-f411re platform, the main PLL is
  // configured for the device's maximum HCLK (216 MHz here, which
  // additionally requires enabling Over-Drive mode), matching the
  // nucleo-f767zi-cubemx platform's clock tree.
  class system_clock
  {
  public:
    system_clock () = default;

    system_clock (const system_clock&) = delete;
    system_clock&
    operator= (const system_clock&)
        = delete;

    ~system_clock () = default;

    // Select voltage scale 1 and enable Over-Drive mode (required for
    // HCLK above 180 MHz), set the flash latency and enable the
    // prefetch buffer and ART accelerator for 216 MHz, bring up HSE
    // in bypass mode, configure the main PLL for a 216 MHz SYSCLK/
    // HCLK, and switch SYSCLK to it, dividing APB1 (PCLK1) by 4 (its
    // 54 MHz maximum) and APB2 (PCLK2) by 2 (its 108 MHz maximum).
    // Returns the resulting HCLK frequency, in Hz.
    std::uint32_t
    initialise (void);

    // Read back the clock configuration registers (RCC_PLLCFGR,
    // RCC_CFGR) and compute the current HCLK frequency, in Hz.
    // Assumes SYSCLK is sourced from the main PLL, fed from HSE, as
    // programmed by initialise().
    std::uint32_t
    clock_get_frequency_hz (void);
  };
} // namespace device

#endif // defined(__cplusplus)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_STM32F767ZI_SYSTEM_CLOCK_H_

// ----------------------------------------------------------------------------
