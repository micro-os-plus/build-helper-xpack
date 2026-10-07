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

// ----------------------------------------------------------------------------

// The GPIOB/RCC macros below expand to C-style pointer casts (e.g.
// `((GPIO_TypeDef*) GPIOB_BASE)`); silence the resulting warning at
// each expansion site below, since micro-os-plus/device.h only covers
// casts made while parsing stm32f7xx.h itself, not macro uses here.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
#endif // defined(__GNUC__)

namespace platform
{
  void
  led_green::power_up (void)
  {
    // Enable the GPIOB clock (harmless if some other pin already did,
    // e.g. PB3/PB4 for SWD/JTAG or the other two onboard LEDs).
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;

    // Drive low before switching the pin to output, so the LED does
    // not glitch on while ODR still holds its reset value.
    GPIOB->BSRR = GPIO_BSRR_BR0;

    // Configure PB0 as a general-purpose output, push-pull, no pull,
    // low speed (the LED does not need to switch fast).
    GPIOB->MODER
        = (GPIOB->MODER & ~GPIO_MODER_MODER0_Msk) | GPIO_MODER_MODER0_0;
    GPIOB->OTYPER &= ~GPIO_OTYPER_OT0;
    GPIOB->OSPEEDR &= ~GPIO_OSPEEDR_OSPEEDR0_Msk;
    GPIOB->PUPDR &= ~GPIO_PUPDR_PUPDR0_Msk;
  }

  void
  led_green::turn_on (void)
  {
    // Active-high: set the pin to turn the LED on.
    GPIOB->BSRR = GPIO_BSRR_BS0;
  }

  void
  led_green::turn_off (void)
  {
    // Active-high: reset the pin to turn the LED off.
    GPIOB->BSRR = GPIO_BSRR_BR0;
  }

  void
  led_green::toggle (void)
  {
    GPIOB->ODR ^= GPIO_ODR_OD0;
  }

  void
  led_green::power_down (void)
  {
    // Return the pin to its reset function (analog, MODER = 0b11);
    // OTYPER/OSPEEDR/PUPDR do not matter once the pin is analog again.
    GPIOB->MODER |= GPIO_MODER_MODER0_Msk;
  }

} // namespace platform

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------
