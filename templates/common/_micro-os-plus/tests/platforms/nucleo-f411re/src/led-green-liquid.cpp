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

// The GPIOA/RCC macros below expand to C-style pointer casts (e.g.
// `((GPIO_TypeDef*) GPIOA_BASE)`); silence the resulting warning at
// each expansion site below, since micro-os-plus/device.h only covers
// casts made while parsing stm32f4xx.h itself, not macro uses here.
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
#endif // defined(__GNUC__)

namespace platform
{
  void
  led_green::power_up (void)
  {
    // Enable the GPIOA clock (harmless if some other pin already did,
    // e.g. PA2/PA3 for USART2 or the SWD pins).
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    // Drive low before switching the pin to output, so the LED does
    // not glitch on while ODR still holds its reset value.
    GPIOA->BSRR = GPIO_BSRR_BR5;

    // Configure PA5 as a general-purpose output, push-pull, no pull,
    // low speed (the LED does not need to switch fast).
    GPIOA->MODER
        = (GPIOA->MODER & ~GPIO_MODER_MODER5_Msk) | GPIO_MODER_MODER5_0;
    GPIOA->OTYPER &= ~GPIO_OTYPER_OT5;
    GPIOA->OSPEEDR &= ~GPIO_OSPEEDR_OSPEED5_Msk;
    GPIOA->PUPDR &= ~GPIO_PUPDR_PUPD5_Msk;
  }

  void
  led_green::turn_on (void)
  {
    // Active-high: set the pin to turn the LED on.
    GPIOA->BSRR = GPIO_BSRR_BS5;
  }

  void
  led_green::turn_off (void)
  {
    // Active-high: reset the pin to turn the LED off.
    GPIOA->BSRR = GPIO_BSRR_BR5;
  }

  void
  led_green::toggle (void)
  {
    GPIOA->ODR ^= GPIO_ODR_OD5;
  }

  void
  led_green::power_down (void)
  {
    // Return the pin to its reset function (analog, MODER = 0b11);
    // OTYPER/OSPEEDR/PUPDR do not matter once the pin is analog again.
    GPIOA->MODER |= GPIO_MODER_MODER5_Msk;
  }

} // namespace platform

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------
