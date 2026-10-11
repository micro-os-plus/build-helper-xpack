/*
 * DO NOT EDIT! Automatically generated from template file:
 * platforms/nucleo-h533re/device/stm32cubemx/startup_stm32h533xx.s
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
void PVD_AVD_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RTC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RTC_S_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TAMP_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RAMCFG_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FLASH_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FLASH_S_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GTZC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RCC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RCC_S_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI7_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI8_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI9_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI10_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI11_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI12_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI13_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI14_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void EXTI15_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA1_Channel7_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void IWDG_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SAES_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void ADC1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DAC1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FDCAN1_IT0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FDCAN1_IT1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_BRK_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_UP_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_TRG_COM_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM1_CC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM7_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C1_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C1_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C2_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C2_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USART1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USART2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USART3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void UART4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void UART5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void LPUART1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void LPTIM1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM8_BRK_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM8_UP_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM8_TRG_COM_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM8_CC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void ADC2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void LPTIM2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM15_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USB_DRD_FS_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void CRS_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void UCPD1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FMC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void OCTOSPI1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SDMMC1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C3_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I2C3_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SPI4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void USART6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel2_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel3_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel4_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel5_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel6_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void GPDMA2_Channel7_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FPU_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void ICACHE_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DCACHE1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DCMI_PSSI_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FDCAN2_IT0_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void FDCAN2_IT1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DTS_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void RNG_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void OTFDEC1_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void AES_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void HASH_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void PKA_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void CEC_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void TIM12_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I3C1_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I3C1_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I3C2_EV_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));
void I3C2_ER_IRQHandler(void) __attribute__ ((weak, alias ("Default_Handler")));

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
    SecureFault_Handler,               // The Secure Fault handler
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

    WWDG_IRQHandler,
    PVD_AVD_IRQHandler,
    RTC_IRQHandler,
    RTC_S_IRQHandler,
    TAMP_IRQHandler,
    RAMCFG_IRQHandler,
    FLASH_IRQHandler,
    FLASH_S_IRQHandler,
    GTZC_IRQHandler,
    RCC_IRQHandler,
    RCC_S_IRQHandler,
    EXTI0_IRQHandler,
    EXTI1_IRQHandler,
    EXTI2_IRQHandler,
    EXTI3_IRQHandler,
    EXTI4_IRQHandler,
    EXTI5_IRQHandler,
    EXTI6_IRQHandler,
    EXTI7_IRQHandler,
    EXTI8_IRQHandler,
    EXTI9_IRQHandler,
    EXTI10_IRQHandler,
    EXTI11_IRQHandler,
    EXTI12_IRQHandler,
    EXTI13_IRQHandler,
    EXTI14_IRQHandler,
    EXTI15_IRQHandler,
    GPDMA1_Channel0_IRQHandler,
    GPDMA1_Channel1_IRQHandler,
    GPDMA1_Channel2_IRQHandler,
    GPDMA1_Channel3_IRQHandler,
    GPDMA1_Channel4_IRQHandler,
    GPDMA1_Channel5_IRQHandler,
    GPDMA1_Channel6_IRQHandler,
    GPDMA1_Channel7_IRQHandler,
    IWDG_IRQHandler,
    SAES_IRQHandler,
    ADC1_IRQHandler,
    DAC1_IRQHandler,
    FDCAN1_IT0_IRQHandler,
    FDCAN1_IT1_IRQHandler,
    TIM1_BRK_IRQHandler,
    TIM1_UP_IRQHandler,
    TIM1_TRG_COM_IRQHandler,
    TIM1_CC_IRQHandler,
    TIM2_IRQHandler,
    TIM3_IRQHandler,
    TIM4_IRQHandler,
    TIM5_IRQHandler,
    TIM6_IRQHandler,
    TIM7_IRQHandler,
    I2C1_EV_IRQHandler,
    I2C1_ER_IRQHandler,
    I2C2_EV_IRQHandler,
    I2C2_ER_IRQHandler,
    SPI1_IRQHandler,
    SPI2_IRQHandler,
    SPI3_IRQHandler,
    USART1_IRQHandler,
    USART2_IRQHandler,
    USART3_IRQHandler,
    UART4_IRQHandler,
    UART5_IRQHandler,
    LPUART1_IRQHandler,
    LPTIM1_IRQHandler,
    TIM8_BRK_IRQHandler,
    TIM8_UP_IRQHandler,
    TIM8_TRG_COM_IRQHandler,
    TIM8_CC_IRQHandler,
    ADC2_IRQHandler,
    LPTIM2_IRQHandler,
    TIM15_IRQHandler,
    0,
    0,
    USB_DRD_FS_IRQHandler,
    CRS_IRQHandler,
    UCPD1_IRQHandler,
    FMC_IRQHandler,
    OCTOSPI1_IRQHandler,
    SDMMC1_IRQHandler,
    I2C3_EV_IRQHandler,
    I2C3_ER_IRQHandler,
    SPI4_IRQHandler,
    0,
    0,
    USART6_IRQHandler,
    0,
    0,
    0,
    0,
    GPDMA2_Channel0_IRQHandler,
    GPDMA2_Channel1_IRQHandler,
    GPDMA2_Channel2_IRQHandler,
    GPDMA2_Channel3_IRQHandler,
    GPDMA2_Channel4_IRQHandler,
    GPDMA2_Channel5_IRQHandler,
    GPDMA2_Channel6_IRQHandler,
    GPDMA2_Channel7_IRQHandler,
    0,
    0,
    0,
    0,
    0,
    FPU_IRQHandler,
    ICACHE_IRQHandler,
    DCACHE1_IRQHandler,
    0,
    0,
    DCMI_PSSI_IRQHandler,
    FDCAN2_IT0_IRQHandler,
    FDCAN2_IT1_IRQHandler,
    0,
    0,
    DTS_IRQHandler,
    RNG_IRQHandler,
    OTFDEC1_IRQHandler,
    AES_IRQHandler,
    HASH_IRQHandler,
    PKA_IRQHandler,
    CEC_IRQHandler,
    TIM12_IRQHandler,
    0,
    0,
    I3C1_EV_IRQHandler,
    I3C1_ER_IRQHandler,
    0,
    0,
    0,
    0,
    0,
    0,
    I3C2_EV_IRQHandler,
    I3C2_ER_IRQHandler
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
