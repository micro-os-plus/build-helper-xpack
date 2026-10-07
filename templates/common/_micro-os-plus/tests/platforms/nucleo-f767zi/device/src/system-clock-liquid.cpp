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
// made while parsing stm32f7xx.h itself, not macro uses here.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
#endif // defined(__GNUC__)

namespace device
{
  // Nominal frequency of the clock the onboard ST-Link feeds into
  // PH0/OSC_IN; matches RCC.HSE_VALUE in stm32cubemx.ioc. Confirmed
  // working on real hardware; see system-clock.h.
  static constexpr std::uint32_t hse_hz = 16'000'000;

  // PLL: 16 MHz / 8 = 2 MHz VCO input (the value ST recommends, for
  // the best jitter performance) * 216 = 432 MHz VCO (the maximum
  // this PLL supports) / 2 = 216 MHz SYSCLK, the maximum HCLK the
  // STM32F767 supports (only reachable with Over-Drive mode, enabled
  // below).
  static constexpr std::uint32_t pll_m = 8;
  static constexpr std::uint32_t pll_n = 216;
  // PLLP is encoded as (PLLP / 2 - 1); 0 selects PLLP = 2.
  static constexpr std::uint32_t pll_p_field = 0;
  static constexpr std::uint32_t pll_p = 2;
  // PLLQ and PLLR (the latter unique to the F76x/F77x subfamily, for
  // SDMMC2/DSI) are unused here (no USB/SDIO/RNG/SDMMC2/DSI enabled);
  // set to their minimum valid divisor (2), matching the
  // CubeMX-generated nucleo-f767zi-cubemx platform's SystemClock_Config().
  static constexpr std::uint32_t pll_q = 2;
  static constexpr std::uint32_t pll_r = 2;

  std::uint32_t
  system_clock::initialise (void)
  {
    // Select voltage scale 1 (required above 144 MHz HCLK).
    RCC->APB1ENR |= RCC_APB1ENR_PWREN;
    PWR->CR1 = (PWR->CR1 & ~PWR_CR1_VOS_Msk) | PWR_CR1_VOS_Msk;

    // Bring up HSE in bypass mode (an external clock signal is being
    // fed in, not a resonator); HSEBYP may only be written while
    // HSEON is cleared, which it already is, at reset.
    RCC->CR |= RCC_CR_HSEBYP;
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY))
      {
        // Busy wait for HSE to stabilise (or, if the clock signal is
        // not actually present on this board, forever).
      }

    // Configure the main PLL, sourced from HSE.
    RCC->PLLCFGR = (pll_m << RCC_PLLCFGR_PLLM_Pos)
                   | (pll_n << RCC_PLLCFGR_PLLN_Pos)
                   | (pll_p_field << RCC_PLLCFGR_PLLP_Pos)
                   | (pll_q << RCC_PLLCFGR_PLLQ_Pos)
                   | (pll_r << RCC_PLLCFGR_PLLR_Pos) | RCC_PLLCFGR_PLLSRC_HSE;

    RCC->CR |= RCC_CR_PLLON;
    while (!(RCC->CR & RCC_CR_PLLRDY))
      {
        // Busy wait for the PLL to lock.
      }

    // Enable Over-Drive mode (required above 180 MHz HCLK), once the
    // PLL feeding it is stable, and wait for the regulator and the
    // clock switch to become ready.
    PWR->CR1 |= PWR_CR1_ODEN;
    while (!(PWR->CSR1 & PWR_CSR1_ODRDY))
      {
        // Busy wait for the Over-Drive generator to become ready.
      }

    PWR->CR1 |= PWR_CR1_ODSWEN;
    while (!(PWR->CSR1 & PWR_CSR1_ODSWRDY))
      {
        // Busy wait for the Over-Drive switch to complete.
      }

    // Raise the flash latency for the target HCLK before switching to
    // it below (the reverse order is required when decreasing the
    // frequency), and enable the prefetch buffer and the ART
    // accelerator (shared I-cache/D-cache) for best performance at
    // 216 MHz.
    FLASH->ACR = FLASH_ACR_LATENCY_7WS | FLASH_ACR_PRFTEN | FLASH_ACR_ARTEN;

    // AHB (HCLK) undivided (216 MHz); APB1 (PCLK1) divided by 4 (its
    // 54 MHz maximum); APB2 (PCLK2) divided by 2 (its 108 MHz
    // maximum).
    RCC->CFGR
        = (RCC->CFGR
           & ~(RCC_CFGR_HPRE_Msk | RCC_CFGR_PPRE1_Msk | RCC_CFGR_PPRE2_Msk))
          | RCC_CFGR_HPRE_DIV1 | RCC_CFGR_PPRE1_DIV4 | RCC_CFGR_PPRE2_DIV2;

    // Switch SYSCLK to the PLL.
    RCC->CFGR = (RCC->CFGR & ~RCC_CFGR_SW_Msk) | RCC_CFGR_SW_PLL;
    while ((RCC->CFGR & RCC_CFGR_SWS_Msk) != RCC_CFGR_SWS_PLL)
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
