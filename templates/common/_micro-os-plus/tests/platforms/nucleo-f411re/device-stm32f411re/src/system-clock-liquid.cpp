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

#include "micro-os-plus/device.h"

// ----------------------------------------------------------------------------

// The RCC/FLASH/PWR macros below expand to C-style pointer casts (e.g.
// `((RCC_TypeDef*) RCC_BASE)`); silence the resulting warning at each
// expansion site below, since micro-os-plus/device.h only covers casts
// made while parsing stm32f4xx.h itself, not macro uses here.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
#endif // defined(__GNUC__)

namespace device
{
  // Nucleo-F411RE has no HSE crystal; PH0-OSC_IN is fed an 8 MHz clock
  // signal by the onboard ST-LINK's own MCO output (matching HSE_VALUE
  // in the CubeMX-generated stm32f4xx_hal_conf.h), so HSE is used in
  // bypass mode below, not as a resonator.
  static constexpr std::uint32_t hse_hz = 8'000'000;

  // PLL: 8 MHz / 4 = 2 MHz VCO input (the value ST recommends, for the
  // best jitter performance) * 96 = 192 MHz VCO / 2 = 96 MHz SYSCLK,
  // matching the CubeMX-generated platforms (whose default clock tree
  // keeps PLLQ at a clean 48 MHz), even though the STM32F411 itself
  // supports up to 100 MHz HCLK.
  static constexpr std::uint32_t pll_m = 4;
  static constexpr std::uint32_t pll_n = 96;
  // PLLP is encoded as (PLLP / 2 - 1); 0 selects PLLP = 2.
  static constexpr std::uint32_t pll_p_field = 0;
  static constexpr std::uint32_t pll_p = 2;

  std::uint32_t
  system_clock::initialise (void)
  {
    // Raise the flash latency for the target HCLK before raising the
    // clock itself (the reverse order is required when decreasing the
    // frequency), and enable the ART accelerator (prefetch, I-cache,
    // D-cache) for best performance at 96 MHz.
    FLASH->ACR = FLASH_ACR_LATENCY_3WS | FLASH_ACR_PRFTEN | FLASH_ACR_ICEN
                 | FLASH_ACR_DCEN;

    // Select voltage scale 1 (required for HCLK above 64 MHz).
    RCC->APB1ENR |= RCC_APB1ENR_PWREN;
    PWR->CR |= PWR_CR_VOS;

    // Bring up HSE in bypass mode (an external clock signal is being
    // fed in, not a resonator); HSEBYP may only be written while
    // HSEON is cleared, which it already is, at reset.
    RCC->CR |= RCC_CR_HSEBYP;
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY))
      {
        // Busy wait for HSE to stabilise.
      }

    // Configure the main PLL, sourced from HSE; PLLQ is left at its
    // reset value (4), unused since USB/SDIO/RNG are not enabled here.
    RCC->PLLCFGR
        = (pll_m << RCC_PLLCFGR_PLLM_Pos) | (pll_n << RCC_PLLCFGR_PLLN_Pos)
          | (pll_p_field << RCC_PLLCFGR_PLLP_Pos) | RCC_PLLCFGR_PLLSRC_HSE;

    RCC->CR |= RCC_CR_PLLON;
    while (!(RCC->CR & RCC_CR_PLLRDY))
      {
        // Busy wait for the PLL to lock.
      }

    // AHB (HCLK) undivided (96 MHz); APB1 (PCLK1) divided by 2 (48 MHz,
    // within its 50 MHz maximum); APB2 (PCLK2) undivided (within its
    // 100 MHz maximum).
    RCC->CFGR
        = (RCC->CFGR
           & ~(RCC_CFGR_HPRE_Msk | RCC_CFGR_PPRE1_Msk | RCC_CFGR_PPRE2_Msk))
          | RCC_CFGR_HPRE_DIV1 | RCC_CFGR_PPRE1_DIV2 | RCC_CFGR_PPRE2_DIV1;

    // Switch SYSCLK to the PLL.
    RCC->CFGR = (RCC->CFGR & ~RCC_CFGR_SW) | RCC_CFGR_SW_PLL;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL)
      {
        // Busy wait for the glitchless mux to settle on the PLL.
      }

    return clock_get_frequency_hz ();
  }

  std::uint32_t
  system_clock::clock_get_frequency_hz (void)
  {
    // Assumes SYSCLK is sourced from the main PLL, fed from HSE, as
    // programmed by initialise(); nothing else in this codebase
    // changes the source afterwards.
    std::uint32_t m
        = (RCC->PLLCFGR & RCC_PLLCFGR_PLLM_Msk) >> RCC_PLLCFGR_PLLM_Pos;
    std::uint32_t n
        = (RCC->PLLCFGR & RCC_PLLCFGR_PLLN_Msk) >> RCC_PLLCFGR_PLLN_Pos;
    std::uint32_t p_field
        = (RCC->PLLCFGR & RCC_PLLCFGR_PLLP_Msk) >> RCC_PLLCFGR_PLLP_Pos;
    std::uint32_t p = (p_field + 1) * 2;

    std::uint32_t vco_hz = (hse_hz / m) * n;
    std::uint32_t pllclk_hz = vco_hz / p;

    static constexpr std::uint32_t hpre_shift[16]
        = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 6, 7, 8, 9 };
    std::uint32_t hpre = (RCC->CFGR & RCC_CFGR_HPRE_Msk) >> RCC_CFGR_HPRE_Pos;

    return pllclk_hz >> hpre_shift[hpre];
  }

} // namespace device

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------
