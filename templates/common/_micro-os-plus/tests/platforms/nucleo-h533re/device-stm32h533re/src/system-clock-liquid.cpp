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
// made while parsing stm32h5xx.h itself, not macro uses here.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
#endif // defined(__GNUC__)

namespace device
{
  // Nominal frequency of the on-board X3 crystal; Nucleo-H533RE ships
  // with it populated and selected by default (unlike Nucleo-F411RE/
  // F767ZI, whose HSE instead defaults to the ST-LINK's MCO output).
  // Matches RCC.HSE_VALUE in stm32cubemx.ioc.
  static constexpr std::uint32_t hse_hz = 24'000'000;

  // PLL1: 24 MHz / 3 = 8 MHz VCI (VCIRANGE_3, 8-16 MHz) * 62.5
  // (fractional N: N = 62, FRACN = 4096 / 8192) = 500 MHz VCO (wide
  // range, 192-836 MHz) / 2 = 250 MHz SYSCLK, the maximum HCLK the
  // STM32H533 supports.
  static constexpr std::uint32_t pll_m = 3;
  static constexpr std::uint32_t pll_fracn = 4096;
  // PLL1DIVR's N/P/Q/R fields hold (value - 1); only the P output is
  // enabled below (feeding SYSCLK), Q and R are unused here and left
  // at their minimum divisor.
  static constexpr std::uint32_t pll_n_field = 61;
  static constexpr std::uint32_t pll_p_field = 1;
  static constexpr std::uint32_t pll_q_field = 1;
  static constexpr std::uint32_t pll_r_field = 1;

  std::uint32_t
  system_clock::initialise (void)
  {
    // Select voltage scale 0 (required for HCLK above roughly
    // 200 MHz) and wait for the regulator to reach it.
    PWR->VOSCR = (PWR->VOSCR & ~PWR_VOSCR_VOS_Msk) | PWR_VOSCR_VOS_Msk;
    while (!(PWR->VOSSR & PWR_VOSSR_VOSRDY))
      {
        // Busy wait for the regulator to reach the new voltage scale.
      }

    // Bring up HSE on the on-board 24 MHz X3 crystal; not bypass, as
    // this board's default wiring drives an actual crystal on
    // OSC_IN/OSC_OUT, unlike F411RE/F767ZI's ST-LINK MCO signal.
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY))
      {
        // Busy wait for HSE to stabilise (or, if the crystal is not
        // actually populated on this board, forever).
      }

    // Configure PLL1's fractional divider and integer dividers while
    // PLL1FRACEN is still clear (its reset state, since PLL1 has not
    // been touched yet); no on-the-fly FRACN update dance is needed
    // for this cold bring-up.
    RCC->PLL1FRACR = pll_fracn << RCC_PLL1FRACR_PLL1FRACN_Pos;

    RCC->PLL1DIVR = (pll_n_field << RCC_PLL1DIVR_PLL1N_Pos)
                    | (pll_p_field << RCC_PLL1DIVR_PLL1P_Pos)
                    | (pll_q_field << RCC_PLL1DIVR_PLL1Q_Pos)
                    | (pll_r_field << RCC_PLL1DIVR_PLL1R_Pos);

    // Configure PLL1, sourced from HSE (PLL1SRC = 0b11): VCI range
    // 8-16 MHz (PLL1RGE = 0b11), fractional mode enabled (latching
    // the FRACN value written above), wide VCO range, 192-836 MHz
    // (PLL1VCOSEL left clear), and only the P output enabled.
    RCC->PLL1CFGR = RCC_PLL1CFGR_PLL1SRC_0 | RCC_PLL1CFGR_PLL1SRC_1
                    | RCC_PLL1CFGR_PLL1RGE_0 | RCC_PLL1CFGR_PLL1RGE_1
                    | RCC_PLL1CFGR_PLL1FRACEN
                    | (pll_m << RCC_PLL1CFGR_PLL1M_Pos) | RCC_PLL1CFGR_PLL1PEN;

    RCC->CR |= RCC_CR_PLL1ON;
    while (!(RCC->CR & RCC_CR_PLL1RDY))
      {
        // Busy wait for PLL1 to lock.
      }

    // Raise the flash latency (5 wait states) and the high-frequency
    // write delay for the target HCLK before switching to it below
    // (the reverse order is required when decreasing the frequency).
    FLASH->ACR
        = (FLASH->ACR & ~(FLASH_ACR_LATENCY_Msk | FLASH_ACR_WRHIGHFREQ_Msk))
          | FLASH_ACR_LATENCY_5WS | FLASH_ACR_WRHIGHFREQ_1;

    // AHB (HCLK), APB1 (PCLK1), APB2 (PCLK2) and APB3 (PCLK3) all
    // undivided (250 MHz, at their maxima); already the case at
    // reset, set explicitly for clarity.
    RCC->CFGR2 &= ~(RCC_CFGR2_HPRE_Msk | RCC_CFGR2_PPRE1_Msk
                    | RCC_CFGR2_PPRE2_Msk | RCC_CFGR2_PPRE3_Msk);

    // Switch SYSCLK to PLL1.
    RCC->CFGR1 = (RCC->CFGR1 & ~RCC_CFGR1_SW_Msk) | RCC_CFGR1_SW_Msk;
    while ((RCC->CFGR1 & RCC_CFGR1_SWS_Msk) != RCC_CFGR1_SWS_Msk)
      {
        // Busy wait for the glitchless mux to settle on PLL1.
      }

    return clock_get_frequency_hz ();
  }

  std::uint32_t
  system_clock::clock_get_frequency_hz (void)
  {
    // Assumes SYSCLK is sourced from PLL1, fed from HSE, as
    // programmed by initialise(); nothing else in this codebase
    // changes the source afterwards.
    std::uint32_t m
        = (RCC->PLL1CFGR & RCC_PLL1CFGR_PLL1M_Msk) >> RCC_PLL1CFGR_PLL1M_Pos;
    std::uint32_t n
        = ((RCC->PLL1DIVR & RCC_PLL1DIVR_PLL1N_Msk) >> RCC_PLL1DIVR_PLL1N_Pos)
          + 1;
    std::uint32_t p
        = ((RCC->PLL1DIVR & RCC_PLL1DIVR_PLL1P_Msk) >> RCC_PLL1DIVR_PLL1P_Pos)
          + 1;
    std::uint32_t fracn = (RCC->PLL1FRACR & RCC_PLL1FRACR_PLL1FRACN_Msk)
                          >> RCC_PLL1FRACR_PLL1FRACN_Pos;

    // VCO frequency, in Hz, using the fractional N (N + FRACN / 8192),
    // computed in fixed point (x8192) to avoid floating point.
    std::uint64_t vco_x8192_hz
        = (static_cast<std::uint64_t> (hse_hz) * ((n << 13) + fracn)) / m;
    std::uint32_t pll1clk_hz
        = static_cast<std::uint32_t> (vco_x8192_hz / (8192ULL * p));

    static constexpr std::uint32_t hpre_shift[16]
        = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 6, 7, 8, 9 };
    std::uint32_t hpre
        = (RCC->CFGR2 & RCC_CFGR2_HPRE_Msk) >> RCC_CFGR2_HPRE_Pos;

    return pll1clk_hz >> hpre_shift[hpre];
  }

} // namespace device

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------
