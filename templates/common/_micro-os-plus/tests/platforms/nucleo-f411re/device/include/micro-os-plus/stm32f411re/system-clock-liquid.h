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

#ifndef MICRO_OS_PLUS_STM32F411RE_SYSTEM_CLOCK_H_
#define MICRO_OS_PLUS_STM32F411RE_SYSTEM_CLOCK_H_

// ----------------------------------------------------------------------------

// This is a C++ only header (the driver is a class, not a C API); do not
// include it from C translation units.
#if defined(__cplusplus)

#include <cstdint>

namespace device
{
  // Driver bringing the STM32F411 system clock up to 96 MHz (matching
  // the CubeMX-generated platforms' clock tree, rather than this
  // device's 100 MHz maximum), implemented directly on the CMSIS
  // `RCC`/`FLASH`/`PWR` register structs (no HAL calls).
  //
  // Nucleo-F411RE has no separate HSE crystal; PH0-OSC_IN is instead
  // fed an 8 MHz clock signal by the onboard ST-LINK's own MCO output
  // (see HSE_VALUE in the CubeMX-generated stm32f4xx_hal_conf.h), so
  // HSE is brought up in bypass mode (`RCC_CR_HSEBYP`), not as a
  // resonator.
  class system_clock
  {
  public:
    system_clock () = default;

    system_clock (const system_clock&) = delete;
    system_clock&
    operator= (const system_clock&)
        = delete;

    ~system_clock () = default;

    // Bring up HSE (bypass, fed by the ST-LINK MCO), configure the
    // main PLL for a 96 MHz SYSCLK/HCLK, raise the flash latency and
    // enable the ART accelerator (prefetch, I-cache, D-cache) for
    // that frequency, select voltage scale 1 (required above 64 MHz),
    // and switch SYSCLK to the PLL. Returns the resulting HCLK
    // frequency, in Hz.
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

#endif // MICRO_OS_PLUS_STM32F411RE_SYSTEM_CLOCK_H_

// ----------------------------------------------------------------------------
