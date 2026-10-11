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

#ifndef MICRO_OS_PLUS_STM32H533RE_SYSTEM_CLOCK_H_
#define MICRO_OS_PLUS_STM32H533RE_SYSTEM_CLOCK_H_

// ----------------------------------------------------------------------------

// This is a C++ only header (the driver is a class, not a C API); do not
// include it from C translation units.
#if defined(__cplusplus)

#include <cstdint>

namespace device
{
  // Driver bringing up the STM32H533 system clock on HSE, fed by the
  // on-board 24 MHz X3 crystal (populated and selected by default on
  // this board, unlike the sibling nucleo-f411re/nucleo-f767zi
  // platforms, whose HSE instead defaults to the ST-LINK's MCO
  // output), driving the main PLL1 for a 250 MHz SYSCLK/HCLK, the
  // device's maximum; implemented directly on the CMSIS `RCC`/
  // `FLASH`/`PWR` register structs (no HAL calls), matching the
  // nucleo-h533re-cubemx platform's clock tree.
  //
  // An earlier revision of this driver instead reproduced the
  // original STM32CubeMX project's modest HSI/2 (32 MHz), no-PLL
  // clock tree; an even earlier attempt at HSE hung on `HSERDY`,
  // apparently from assuming bypass mode (as on F411RE/F767ZI)
  // instead of crystal mode, on a board that, per its `.ioc`, ships
  // with the crystal populated and the ST-LINK MCO path disconnected.
  class system_clock
  {
  public:
    system_clock () = default;

    system_clock (const system_clock&) = delete;
    system_clock&
    operator= (const system_clock&)
        = delete;

    ~system_clock () = default;

    // Select voltage scale 0 (required for HCLK above roughly
    // 200 MHz) and wait for the regulator to report ready, bring up
    // HSE on the on-board crystal, configure PLL1 for a 250 MHz
    // SYSCLK/HCLK, set the flash latency and high-frequency write
    // delay for that frequency (5 wait states, extra write delay),
    // and switch SYSCLK to PLL1, leaving AHB (HCLK), APB1 (PCLK1),
    // APB2 (PCLK2) and APB3 (PCLK3) undivided. Returns the resulting
    // HCLK frequency, in Hz.
    std::uint32_t
    initialise (void);

    // Read back the clock configuration registers (RCC_PLL1CFGR,
    // RCC_PLL1DIVR, RCC_PLL1FRACR, RCC_CFGR2) and compute the current
    // HCLK frequency, in Hz. Assumes SYSCLK is sourced from PLL1, fed
    // from HSE, as programmed by initialise().
    std::uint32_t
    clock_get_frequency_hz (void);
  };
} // namespace device

#endif // defined(__cplusplus)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_STM32H533RE_SYSTEM_CLOCK_H_

// ----------------------------------------------------------------------------
