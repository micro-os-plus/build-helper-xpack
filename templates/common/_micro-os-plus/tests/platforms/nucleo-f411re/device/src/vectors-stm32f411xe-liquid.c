/*
 * DO NOT EDIT! Automatically generated from template file:
 * platforms/nucleo-f411re/device/stm32cubemx/startup_stm32f411xe.s
 *
 * This file is part of the µOS++ project (https://micro-os-plus.github.io/).
 * Copyright (c) 2023-{{currentYear}} Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can be
 * obtained from https://opensource.org/licenses/mit.
 */

// clang-format off
// ----------------------------------------------------------------------------

#include "micro-os-plus/architecture.h"
#include "micro-os-plus/architecture-cortexm/exception-handlers.h"

// ----------------------------------------------------------------------------

void __attribute__((weak))
Default_Handler(void);

/*
 * Forward declaration of the specific IRQ handlers. These are aliased
 * to the Default_Handler, which is a 'forever' loop. When the application
 * defines an actual handler (with the same name), it will automatically
 * take precedence over these weak definitions.
 */
void WWDG_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void PVD_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TAMP_STAMP_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RTC_WKUP_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FLASH_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RCC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void ADC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI9_5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_BRK_TIM9_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_UP_TIM10_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_TRG_COM_TIM11_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_CC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C1_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C1_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C2_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C2_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USART1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USART2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI15_10_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RTC_Alarm_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void OTG_FS_WKUP_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA1_Stream7_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SDIO_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void OTG_FS_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DMA2_Stream7_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USART6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C3_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C3_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FPU_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));

// ----------------------------------------------------------------------------

extern uint32_t __stack;

typedef void
(*handler_ptr_t)(void);

// ----------------------------------------------------------------------------

#if defined(__GNUC__)
#pragma GCC diagnostic push

#pragma GCC diagnostic ignored "-Wpedantic"
#endif // defined(__GNUC__)

/**
 * The table of interrupt handlers. It has an explicit section name
 * and relies on the linker script to place it at the correct location
 * in memory, usually at the very beginning of the flash bank.
 */
handler_ptr_t _interrupt_vectors[]
__attribute__ ((section(".interrupt_vectors"),used)) =
  {
    // Cortex-M Core Handlers
    (handler_ptr_t) &__stack,          // The Main Stack Pointer (MSP)
    Reset_Handler,                     // The Reset handler

    NMI_Handler,                       // The NMI handler
    HardFault_Handler,                 // The Hard Fault handler
    MemManage_Handler,                 // The MPU fault handler
    BusFault_Handler,                  // The Bus Fault handler
    UsageFault_Handler,                // The Usage Fault handler
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    SVC_Handler,                       // The SVCall handler
    DebugMon_Handler,                  // The Debug Monitor handler
    0,                                 // Reserved
    PendSV_Handler,                    // The PendSV handler
    SysTick_Handler,                   // The SysTick handler

    // ------------------------------------------------------------------------
    // External Interrupt Handlers

    WWDG_IRQHandler,                   // Window WatchDog
    PVD_IRQHandler,                    // PVD through EXTI Line detection
    TAMP_STAMP_IRQHandler,             // Tamper and TimeStamps through the EXTI line
    RTC_WKUP_IRQHandler,               // RTC Wakeup through the EXTI line
    FLASH_IRQHandler,                  // FLASH
    RCC_IRQHandler,                    // RCC
    EXTI0_IRQHandler,                  // EXTI Line0
    EXTI1_IRQHandler,                  // EXTI Line1
    EXTI2_IRQHandler,                  // EXTI Line2
    EXTI3_IRQHandler,                  // EXTI Line3
    EXTI4_IRQHandler,                  // EXTI Line4
    DMA1_Stream0_IRQHandler,           // DMA1 Stream 0
    DMA1_Stream1_IRQHandler,           // DMA1 Stream 1
    DMA1_Stream2_IRQHandler,           // DMA1 Stream 2
    DMA1_Stream3_IRQHandler,           // DMA1 Stream 3
    DMA1_Stream4_IRQHandler,           // DMA1 Stream 4
    DMA1_Stream5_IRQHandler,           // DMA1 Stream 5
    DMA1_Stream6_IRQHandler,           // DMA1 Stream 6
    ADC_IRQHandler,                    // ADC1, ADC2 and ADC3s
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    EXTI9_5_IRQHandler,                // External Line[9:5]s
    TIM1_BRK_TIM9_IRQHandler,          // TIM1 Break and TIM9
    TIM1_UP_TIM10_IRQHandler,          // TIM1 Update and TIM10
    TIM1_TRG_COM_TIM11_IRQHandler,     // TIM1 Trigger and Commutation and TIM11
    TIM1_CC_IRQHandler,                // TIM1 Capture Compare
    TIM2_IRQHandler,                   // TIM2
    TIM3_IRQHandler,                   // TIM3
    TIM4_IRQHandler,                   // TIM4
    I2C1_EV_IRQHandler,                // I2C1 Event
    I2C1_ER_IRQHandler,                // I2C1 Error
    I2C2_EV_IRQHandler,                // I2C2 Event
    I2C2_ER_IRQHandler,                // I2C2 Error
    SPI1_IRQHandler,                   // SPI1
    SPI2_IRQHandler,                   // SPI2
    USART1_IRQHandler,                 // USART1
    USART2_IRQHandler,                 // USART2
    0,                                 // Reserved
    EXTI15_10_IRQHandler,              // External Line[15:10]s
    RTC_Alarm_IRQHandler,              // RTC Alarm (A and B) through EXTI Line
    OTG_FS_WKUP_IRQHandler,            // USB OTG FS Wakeup through EXTI line
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    DMA1_Stream7_IRQHandler,           // DMA1 Stream7
    0,                                 // Reserved
    SDIO_IRQHandler,                   // SDIO
    TIM5_IRQHandler,                   // TIM5
    SPI3_IRQHandler,                   // SPI3
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    DMA2_Stream0_IRQHandler,           // DMA2 Stream 0
    DMA2_Stream1_IRQHandler,           // DMA2 Stream 1
    DMA2_Stream2_IRQHandler,           // DMA2 Stream 2
    DMA2_Stream3_IRQHandler,           // DMA2 Stream 3
    DMA2_Stream4_IRQHandler,           // DMA2 Stream 4
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    OTG_FS_IRQHandler,                 // USB OTG FS
    DMA2_Stream5_IRQHandler,           // DMA2 Stream 5
    DMA2_Stream6_IRQHandler,           // DMA2 Stream 6
    DMA2_Stream7_IRQHandler,           // DMA2 Stream 7
    USART6_IRQHandler,                 // USART6
    I2C3_EV_IRQHandler,                // I2C3 event
    I2C3_ER_IRQHandler,                // I2C3 error
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    0,                                 // Reserved
    FPU_IRQHandler,                    // FPU
    0,                                 // Reserved
    0,                                 // Reserved
    SPI4_IRQHandler,                   // SPI4
    SPI5_IRQHandler                    // SPI5
};

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif // defined(__GNUC__)

// ----------------------------------------------------------------------------

/**
 * The processor ends up here if an unexpected interrupt occurs or a
 * specific handler is not present in the application code.
 * When in DEBUG, it triggers a debug exception to clearly notify
 * the user of the exception and help identify the cause.
 * Otherwise, it enters a forever loop.
 */
void __attribute__ ((section(".after_vectors")))
Default_Handler(void)
{
#if defined(MICRO_OS_PLUS_DEBUG_ENABLED)
  micro_os_plus_architecture_brk();
#endif
  while (1)
    {
      micro_os_plus_architecture_wfi();
    }
}

// ----------------------------------------------------------------------------
